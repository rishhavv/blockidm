// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract Hello {

   address contractOwner;
   uint public permitno=0;

   struct Date{
      uint day;
      uint month;
      uint year;
   }

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

   mapping(string=>user)public userDetails;

   constructor() public{
      contractOwner=msg.sender;
   }


   function issuePermit(string memory _userId,string memory _division,string _permitno,string _signatory) public{
      permitno++;

      string combined=_userId+_division+_permitno+_signatory;
      string _hash1=sha256(combined);
      string _hash2=sha256(_hash1);
      userDetails[_hash1]=user(_userId,_permitno,_division,_signatory); //["Asddsadsk6484"]=>("raman","55","A","ramesh","hash for mongo")
   }

   function isValid(string _hash1) view public{
      return (userDetails[_hash1]!=address(0)?true:false);
   }

}