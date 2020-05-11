package beans;

public class DispatchMemoTran implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer dispatchMemoId;
    private Integer furnishingAssetId;
    private String coachNo;
    
    public DispatchMemoTran()
    {
    	
    }

	public DispatchMemoTran(Integer dispatchMemoId, Integer furnishingAssetId, String coachNo) {
		super();
		this.dispatchMemoId = dispatchMemoId;
		this.furnishingAssetId = furnishingAssetId;
		this.coachNo = coachNo;
	}

	public Integer getDispatchMemoId() {
		return dispatchMemoId;
	}

	public void setDispatchMemoId(Integer dispatchMemoId) {
		this.dispatchMemoId = dispatchMemoId;
	}

	public Integer getFurnishingAssetId() {
		return furnishingAssetId;
	}

	public void setFurnishingAssetId(Integer furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}

	public String getCoachNo() {
		return coachNo;
	}

	public void setCoachNo(String coachNo) {
		this.coachNo = coachNo;
	}

	    
}
