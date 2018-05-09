pragma solidity ^0.4.18;
contract owen{
    address public owner;
    function owen() public {
        owner = msg.sender;
    }
    modifier onlyOwner{
        if(owner != msg.sender){
            revert();
        }else{
            _;
        }
    }
    
}

contract buglist is owen{
    string public projectName;
    mapping(address => uint) public balanceAccount;
    mapping(address => uint) public developers;
    uint public programId = 1;
    struct Program{
        string context;
        uint state;
        address createBy;
        uint createDate;
        address updateBy;
        uint updateDate;
        uint level;
    }
    
    mapping(uint => Program) public programs;
       
    modifier onlyTest{
        if(developers[msg.sender] == 1){
            _;
        }else{
            revert();
        }
    }
    
    modifier onlyDeveloper{
        if(developers[msg.sender] == 2){
            _;
        }else{
            revert();
        }
    }
    
    function buglist(string _projectName) public {
        projectName = _projectName;
    }
    
    function add_developer(address _addr,uint _uint) public onlyOwner{
        if(developers[_addr] == 0 && _uint != 0){
            developers[_addr] = _uint;
        }else{
            revert();
        }
    }
    
    function bugYet(uint _id,uint _u,uint _level) public onlyOwner{
        if(_u == 1 || _u == 2){
             programs[_id].state = _u;
            if(_u == 1){
                balanceAccount[programs[_id].createBy] += _level;
            }
        }else{
            revert();
        }
    }
    
    function createBug(string _context) public onlyTest{
        programs[programId]=Program({context:_context,state:0,createBy:msg.sender,createDate:block.timestamp,updateBy:address(0),updateDate:0,level:0});
        programId+=1;
    }
    
    function updateComplete(uint _id) public onlyDeveloper{
        programs[_id].state=3;
        programs[_id].updateBy=msg.sender;
        programs[_id].updateDate=block.timestamp;
    }
    
    function completeYet(uint _id,uint _state) public onlyOwner{
        if(_state == 4 || _state == 5){
            programs[_id].state=_state;
            if(_state == 4){
                balanceAccount[programs[_id].updateBy] += programs[_id].level*2;
            }
        }else{
            revert();
        }
    }
    
    function getSelfAccount() public view returns(uint){
        address sender = msg.sender;
        return balanceAccount[sender];
    }
}
