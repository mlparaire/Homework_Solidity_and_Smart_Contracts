// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


/* 
* @title: Subnet Masking
* @author: Tianchan Dong
* @notice: This contract illustrate how IP addresses are distributed and calculated
* @notice: This contract has no sanity checks! Only use numbers provided in constructor
*/ 

contract Masking{

    // Return Variables
    string public Country;
    string public ISP;
    string public Institute;
    string public Device;

    // Maps of IP interpretation
    mapping(uint => string) public Countries;
    mapping(uint => string) public ISPs;
    mapping(uint => string) public Institutions;
    mapping(uint => string) public Devices;

    constructor() {
        Countries[34] = "Botswana";
        Countries[58] = "Egypt";
        Countries[125] = "Brazil";
        Countries[148] = "USA";
        Countries[152] = "France";
        Countries[196] = "Singapore";
        ISPs[20] = "Orange";
        ISPs[47] = "Telkom";
        ISPs[139] = "Vodafone";
        Institutions[89] = "University";
        Institutions[167] = "Government";
        Institutions[236] = "HomeNet";
        Devices[13] = "iOS";
        Devices[124] = "Windows";
        Devices[87] = "Android";
        Devices[179] = "Tesla ECU";
    }

    function get_LOS(string memory str) private pure returns(uint){
        {
        bytes memory b = bytes(str);
        return b.length;
        }
    }

    function getSlice(uint256 begin, uint256 end, string memory text) public pure returns(bytes memory) {
        bytes memory slice = new bytes(end-begin+1);
        for(uint i=0;i < end-begin+1;i++){
            slice[i] = bytes(text)[i+begin];
        }
        return slice;    
    }

    function bytesToint(bytes memory b) public pure returns (uint8) {
        uint8 result = 0;
        for(uint i = 0; i < b.length;i++){
                result = (result << 1 | uint8(b[i])-48);
        }
        return result;
    }

    function IP(string memory input) public{
        require(get_LOS(input)==32,"String must be 32 in length\n If not that cannot work");
        bytes memory country_slice = getSlice(0,7,input);
        bytes memory isp_slice = getSlice(8,15,input);
        bytes memory institute_slice = getSlice(16,23   ,input);
        bytes memory device_slice = getSlice(24,31,input);
        
        Country = Countries[bytesToint(country_slice)];
        ISP =  ISPs[bytesToint(isp_slice)];
        Institute = Institutions[bytesToint(institute_slice)];
        Device =  Devices[bytesToint(device_slice)];
        }
} //10011000 00101111 11101100 10110011
  //10011000001011111110110010110011