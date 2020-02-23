pragma solidity  >=0.5.16 <0.7.0;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        if (a == 0) {
            return 0;
        }
        c = a * b;
        assert(c / a == b);
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b>0);
        return a / b;
    }
}

contract Contrato{
    using SafeMath for uint;

    struct Service {
        uint serviceCode;
        address serviceConstituentAddress;
        string serviceDescription;
    }
    struct Mission {
        uint missionCode;
        string missionDescription;
        uint missionCodeFather;
    }

    Service[] private serviceList;
    Mission[] private missionList;

    mapping(address => Service[]) private serviceProviderMap;
    mapping(address => Service[]) private serviceUsingMap;
 
 
    event setServiceEvent(string _description, address _constituentAddress);
 
    function setService(string memory _serviceDescription) public {
        require(bytes(_serviceDescription).length > 0,"Error descripción vacía");
        uint _serviceCode = serviceList.length.add(1);
        serviceList.push(Service(_serviceCode, msg.sender, _serviceDescription));
        emit setServiceEvent(_serviceDescription, msg.sender);
    }

    function setMission(uint _missionCode, string memory _missionDescription, uint _missionCodeFather) public {
        missionList.push(Mission(_missionCode, _missionDescription, _missionCodeFather));
    }
    function getService(uint  _serviceCode) public view returns (address, string memory) {
        Service memory _service;
        uint _i;
        for(_i=0; _i<serviceList.length; _i++)
        {
            if(serviceList[_i].serviceCode==_serviceCode)
            {
                _service=serviceList[_i];
                break;
            }
        }
        return (_service.serviceConstituentAddress, _service.serviceDescription);
    }
}