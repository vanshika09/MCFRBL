package beans;

import java.util.Date;

public class RollingStockCertificate implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private Integer furnishingAssetId;
	private String rscDocNo;
	private String rscRevNo;
	private Date docDate;
	private String orderNo;
	private String rscNo;
	private String rscModification;
    private String rscDeviation;
    
    public RollingStockCertificate()
    {
    	
    }

	public RollingStockCertificate( Integer furnishingAssetId, String rscDocNo, String rscRevNo, 
									Date docDate, String orderNo, String rscNo,
									String rscModification, String rscDeviation) {
		super();
		this.furnishingAssetId = furnishingAssetId;
		this.rscDocNo=rscDocNo;
		this.rscRevNo = rscRevNo;
		this.docDate = docDate;
		this.orderNo=orderNo;
		this.rscNo = rscNo;
		this.rscModification = rscModification;
		this.rscDeviation = rscDeviation;
	}

	public Integer getFurnishingAssetId() {
		return furnishingAssetId;
	}

	public void setFurnishingAssetId(Integer furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}

	public String getRscDocNo() {
		return rscDocNo;
	}

	public void setRscDocNo(String rscDocNo) {
		this.rscDocNo = rscDocNo;
	}

	public String getRscRevNo() {
		return rscRevNo;
	}

	public void setRscRevNo(String rscRevNo) {
		this.rscRevNo = rscRevNo;
	}

	public Date getDocDate() {
		return docDate;
	}

	public void setDocDate(Date docDate) {
		this.docDate = docDate;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getRscNo() {
		return rscNo;
	}

	public void setRscNo(String rscNo) {
		this.rscNo = rscNo;
	}

	

	public String getRscModification() {
		return rscModification;
	}

	public void setRscModification(String rscModification) {
		this.rscModification = rscModification;
	}

	public String getRscDeviation() {
		return rscDeviation;
	}

	public void setRscDeviation(String rscDeviation) {
		this.rscDeviation = rscDeviation;
	}
	
}
