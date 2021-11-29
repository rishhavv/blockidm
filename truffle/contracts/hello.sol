// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
pragma experimental ABIEncoderV2;
contract Hello {

   address contractOwner;
   uint public permitno=0;

   // struct Date{
   //    uint day;
   //    uint month;
   //    uint year;
   // }

   struct user{
      string userId;
      string permitno;
      // Date startDate;
      string division;
      // Date endDate;
      string signatory;
     // string hashSec;
      string name;
   }

   mapping(bytes32=>user)public userDetails;

   // constructor() public{
   //    contractOwner=msg.sender;
   // }


   function issuePermit(string memory _userId,string memory _division,string memory _permitno,string memory _signatory) public returns(bytes32){
      permitno++;
      string memory _name="Rajesh";
      string memory combined=string(abi.encodePacked(_userId,_division,_permitno,_signatory));
      bytes32 _hash1=sha256(abi.encode(combined));
      //bytes32 _hash2=sha256(_hash1);
      userDetails[_hash1]=user(_userId,_permitno,_division,_signatory,_name); //["Asddsadsk6484"]=>("raman","55","A","ramesh","hash for mongo")
      return _hash1;
   }

   function isValid(bytes32 _hash1) view public returns(bool){
      bytes memory tempEmptyStringTest = bytes(userDetails[_hash1].userId); // Uses memory
      return (tempEmptyStringTest.length==0?false:true);
   }

}