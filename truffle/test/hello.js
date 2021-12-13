const idcontract = artifacts.require("Hello");
contract('iscontract',()=>{
    it('should deploy smart contract properly',async()=>{
        const id=await idcontract.deployed();
        console.log(id.address);
        assert(id.address!=='');
    });

    it('should set and get the values of data variables',async()=>{
        const id=await idcontract.deployed();
        const issuePermit=await id.issuePermit("1","kangra","anmol","rishav");
        //console.log("issuePermit returns ",issuePermit);
        //const msgBuffer = new TextEncoder().encode("1","kangra","anmol","rishav");                    
        //console.log("adress is ",issuePermit.logs[0].args._hash1);

        const hashHex=issuePermit.logs[0].args._hash1;
        const res=await id.userdata(hashHex);
        //console.log("res is ",res);
        assert(res.name==='anmol');
    })

    it('should cancel the validity of permit',async()=>{
        const id=await idcontract.deployed();
        const issuePermit=await id.issuePermit("1","kangra","anmol","rishav");

        const hashHex=issuePermit.logs[0].args._hash1;
        const cancelPermit=await id.cancelPermit(hashHex);
        const res=await id.isValid(hashHex);
        //console.log("res is ",res);
        assert(res==false);
    })

    it('should check the validity of permit',async()=>{
        const id=await idcontract.deployed();
        const issuePermit=await id.issuePermit("1","kangra","anmol","rishav");
        const hashHex=issuePermit.logs[0].args._hash1;
        const res=await id.isValid(hashHex);
        //console.log("res is ",res);
        assert(res==true);
    })
});