package beans;
import java.util.Date;

public class TrialGenerationInRsc implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private Integer trialGenerationItemId;
	private Integer furnishingAssetId;
    private String itemParticulars;
    private String frequency;
    private Date fromDate;
    private Date toDate;
    
    public TrialGenerationInRsc()
    {
    	
    }

	public TrialGenerationInRsc(Integer trialGenerationItemId,Integer furnishingAssetId, String itemParticulars, String frequency,
			Date fromDate, Date toDate) {
		super();
		this.trialGenerationItemId=trialGenerationItemId;
		this.furnishingAssetId = furnishingAssetId;
		this.itemParticulars = itemParticulars;
		this.frequency = frequency;
		this.fromDate = fromDate;
		this.toDate = toDate;
	}

	public Integer getTrialGenerationItemId() {
		return trialGenerationItemId;
	}

	public void setTrialGenerationItemId(Integer trialGenerationItemId) {
		this.trialGenerationItemId = trialGenerationItemId;
	}

	public Integer getFurnishingAssetId() {
		return furnishingAssetId;
	}

	public void setFurnishingAssetId(Integer furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}

	public String getItemParticulars() {
		return itemParticulars;
	}

	public void setItemParticulars(String itemParticulars) {
		this.itemParticulars = itemParticulars;
	}

	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public Date getFromDate() {
		return fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	
}
