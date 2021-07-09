pragma solidity ^0.5.11;

contract anticounterfeit{
    
    event Added(uint256 index);

enum State {notSold, Sold}
State public state;

constructor() public {
    state=State.notSold;
}

function changeState() public {
    state=State.Sold;
}
    uint items;
    
    struct Seller{
        uint productId;
        string Productiondate;
        string location;
        address person;
        
    }mapping (uint => Seller) public CheckSeller;
    
    struct Manf{
        string MedicineName;
        uint MedicineId;
        string Patchno;
        address Creator;
        string Productiondate;
        uint Rate;
        string ManfucturerLocation;
        string ManfucturerInfo;
        
    }
    
    mapping(uint=>Manf) public CheckManf;
    
    function AddManf(uint _rate,uint _medicineId,string memory _medicinename,string memory _patchno,string memory _productiondate,string memory _manufacturerlocation,string memory _manfucturerinfo)public returns(bool){
            Manf memory NewManf=Manf(_medicinename,_medicineId,_patchno,msg.sender,_productiondate,_rate,_manufacturerlocation,_manfucturerinfo);
            CheckManf[items]=NewManf;
            items = items+1;
            emit Added(items-1);
            return true;
            
    }
    
    
    function addSeller(uint _productId, string memory _date, string memory _supplierlocation) public returns (bool) {
        require(_productId<items);
        Seller memory NewSeller=Seller(_productId,_date,_supplierlocation,msg.sender);
        CheckSeller[items]=NewSeller;
    items = items+1;
            emit Added(items-1);
        return true;
    }
    
    function isSold() public view returns(bool) {
        return state ==State.Sold;
    }
}