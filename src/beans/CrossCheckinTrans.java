package beans;

import java.util.Date;

//Generated 12 Mar, 2020 1:13:15 PM by Hibernate Tools 4.0.1.Final



/**
* QciPaintTrans generated by hbm2java
*/
public class CrossCheckinTrans implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int furnishingAssetId;
	private String textGeneral;
	private String textFpvc;
	private String textParitionFrame;
	private String textPanel;
	private String textWindowCelling;
	private String textMoulding;
	private String textSeatBerth;
	private String textLavatory;
	private String textPlumbing;
	private String textAirBrake;
	private String textCoachLowering;
	private String textPaint;
	private String textCoachCleaning;
	private String docNo;
	private String docRevNo;
	private Date docDate;
	private Date dateOfTesting;
	private String shiftOfTesting;
	
	public CrossCheckinTrans() {
	}

	public CrossCheckinTrans(int furnishingAssetId, String textGeneral, String textFpvc, String textParitionFrame,
			String textPanel, String textWindowCelling, String textMoulding, String textSeatBerth, String textLavatory,
			String textPlumbing, String textAirBrake, String textCoachLowering, String textPaint,
			String textCoachCleaning, String docNo, String docRevNo, Date docDate, Date dateOfTesting,String shiftOfTesting) {
		super();
		this.furnishingAssetId = furnishingAssetId;
		this.textGeneral = textGeneral;
		this.textFpvc = textFpvc;
		this.textParitionFrame = textParitionFrame;
		this.textPanel = textPanel;
		this.textWindowCelling = textWindowCelling;
		this.textMoulding = textMoulding;
		this.textSeatBerth = textSeatBerth;
		this.textLavatory = textLavatory;
		this.textPlumbing = textPlumbing;
		this.textAirBrake = textAirBrake;
		this.textCoachLowering = textCoachLowering;
		this.textPaint = textPaint;
		this.textCoachCleaning = textCoachCleaning;
		this.docNo = docNo;
		this.docRevNo = docRevNo;
		this.docDate = docDate;
		this.dateOfTesting=dateOfTesting;
		this.shiftOfTesting=shiftOfTesting;
	}

	public int getFurnishingAssetId() {
		return furnishingAssetId;
	}

	public void setFurnishingAssetId(int furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}

	public String getTextGeneral() {
		return textGeneral;
	}

	public void setTextGeneral(String textGeneral) {
		this.textGeneral = textGeneral;
	}

	public String getTextFpvc() {
		return textFpvc;
	}

	public void setTextFpvc(String textFpvc) {
		this.textFpvc = textFpvc;
	}

	public String getTextParitionFrame() {
		return textParitionFrame;
	}

	public void setTextParitionFrame(String textParitionFrame) {
		this.textParitionFrame = textParitionFrame;
	}

	public String getTextPanel() {
		return textPanel;
	}

	public void setTextPanel(String textPanel) {
		this.textPanel = textPanel;
	}

	public String getTextWindowCelling() {
		return textWindowCelling;
	}

	public void setTextWindowCelling(String textWindowCelling) {
		this.textWindowCelling = textWindowCelling;
	}

	public String getTextMoulding() {
		return textMoulding;
	}

	public void setTextMoulding(String textMoulding) {
		this.textMoulding = textMoulding;
	}

	public String getTextSeatBerth() {
		return textSeatBerth;
	}

	public void setTextSeatBerth(String textSeatBerth) {
		this.textSeatBerth = textSeatBerth;
	}

	public String getTextLavatory() {
		return textLavatory;
	}

	public void setTextLavatory(String textLavatory) {
		this.textLavatory = textLavatory;
	}

	public String getTextPlumbing() {
		return textPlumbing;
	}

	public void setTextPlumbing(String textPlumbing) {
		this.textPlumbing = textPlumbing;
	}

	public String getTextAirBrake() {
		return textAirBrake;
	}

	public void setTextAirBrake(String textAirBrake) {
		this.textAirBrake = textAirBrake;
	}

	public String getTextCoachLowering() {
		return textCoachLowering;
	}

	public void setTextCoachLowering(String textCoachLowering) {
		this.textCoachLowering = textCoachLowering;
	}

	public String getTextPaint() {
		return textPaint;
	}

	public void setTextPaint(String textPaint) {
		this.textPaint = textPaint;
	}

	public String getTextCoachCleaning() {
		return textCoachCleaning;
	}

	public void setTextCoachCleaning(String textCoachCleaning) {
		this.textCoachCleaning = textCoachCleaning;
	}

	public String getDocNo() {
		return docNo;
	}

	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}

	public String getDocRevNo() {
		return docRevNo;
	}

	public void setDocRevNo(String docRevNo) {
		this.docRevNo = docRevNo;
	}

	public Date getDocDate() {
		return docDate;
	}

	public void setDocDate(Date docDate) {
		this.docDate = docDate;
	}

	public Date getDateOfTesting() {
		return dateOfTesting;
	}

	public void setDateOfTesting(Date dateOfTesting) {
		this.dateOfTesting = dateOfTesting;
	}

	public String getShiftOfTesting() {
		return shiftOfTesting;
	}

	public void setShiftOfTesting(String shiftOfTesting) {
		this.shiftOfTesting = shiftOfTesting;
	}

	
}