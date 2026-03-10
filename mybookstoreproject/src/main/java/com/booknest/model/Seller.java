package com.booknest.model;



public class Seller {
	
	private int ownerUserId;

	private String name;
	private String email;
	private String password;
	private String phone;
	private String accountStatus; 
	

	private int storeId;
	private String storeName;
	private String storePhone;
	private String city;
	private String state;

	private String idType;
	private String idNumber;
	private String idDocument;
	private String verificationStatus;
    
    
    public Seller() {
    	
    }


	public int getOwnerUserId() {
		return ownerUserId;
	}


	public void setOwnerUserId(int ownerUserId) {
		this.ownerUserId = ownerUserId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}

    
	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAccountStatus() {
	    return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
	    this.accountStatus = accountStatus;
	}

	public int getStoreId() {
		return storeId;
	}


	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}


	public String getStoreName() {
		return storeName;
	}


	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}


	public String getStorePhone() {
		return storePhone;
	}


	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getIdType() {
		return idType;
	}


	public void setIdType(String idType) {
		this.idType = idType;
	}


	public String getIdNumber() {
		return idNumber;
	}


	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}


	public String getIdDocument() {
		return idDocument;
	}


	public void setIdDocument(String idDocument) {
		this.idDocument = idDocument;
	}

    public String getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(String verificationStatus) {
        this.verificationStatus = verificationStatus;
    }

	
    
    
}
