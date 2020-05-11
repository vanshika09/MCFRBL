package beans;

import java.util.Date;

public class ShellTransaction implements java.io.Serializable{

	
	private static final long serialVersionUID = 1L;
	
	private Integer shellAssetId;
	private String shellTransactionId;
	private String stageId;
	private String previousStageId;
	private String underFrameNumber;
	private String shellNumber;
	private String shellType;
	private Date assemblyStartDate;
	private Date expectedExitDate;
	private Date assemblyEndDate;
	private Date assemblyDispatchDate;
	private String transactionDate;
	private String transactionUser;
	private String remarks;
	private String exitRemarks;
	private String lateRemarks;
	private Integer asignedFlag;
	private Date receiptatNextStage;
	private String sideWallMakePp;
	private String sideWallMakeNpp;
	private String sideWallNoPp;
	private String sideWallNoNpp;
	private String roofMake;
	private String roofNo;
	private String lavsidewallMake1;
	private String lavsidewallMake2;
	private String lavsidewallMake3;
	private String lavsidewallMake4;
	private String lavsidewallNo1;
	private String lavsidewallNo2;
	private String lavsidewallNo3;
	private String lavsidewallNo4;
	private String endwallMakePp;
	private String  endwallMakeNpp;
	private String endwallNoPp;
	private String  endwallNoNpp;
	 private Integer endwallSipFlag;
	 private Integer roofSipFlag;
	 private Integer underframeSipFlag;
	 private Integer sidewallSipFlag;
	private Integer lavsidewallSipFlag;
	private Integer stage1SipFlag;
    private Integer stage2SipFlag;
    private Integer stage3SipFlag;
    private Integer stage4SipFlag;
    
    private Integer finalIspectionReportFlag;
    private Integer checkListFlag;
    private Integer testingClearanceMemoFlag;
    private String testingClearanceMemoDocNo;
    private Date testingClearanceMemoDate;
    private String testingClearanceMemoStatus;
   private String testingClearanceMemoRemark;
   private String waterTankBkt1;
   private String waterTankBkt2;
   private String waterTankBkt3;
   private String waterTankBkt4;
   private String cbcFittedByPp;
   private String cbcFittedByNpp;
   private String frntPrtMakePp;
   private String frntPrtMakeNpp;
   private String frntPrtNoPp;
   private String frntPrtNoNpp;
   private String cbCMakePp;
   private String cbCMakeNpp;
   private String cbCNoPp;
   private String cbCNoNpp;
   private String underframeMakePp;
   private String underframeMakeNpp;
   private String underframeNoPp;
   private String underframeNoNpp;
   private String underframeCompleteMake;
   private String underframeCompleteNo;
   private String sideDoorMakeNoLeft;
   private String sideDoorMakeNoRight;
   private String roofAcAssemblyMakeNoPp;
   private String roofAcAssemblyMakeNoNpp;
   private String wtccMakeNoPp;
   private String wtccMakeNoNpp;
   private String slidingDoorMakeNoLeft;
  private String slidingDoorMakeNoRight;
  private String  shellAssembledBy;
 private String jigNo;
 private Integer assemblySipFlag;
	public ShellTransaction()
	{
		
	}

	public ShellTransaction(Integer shellAssetId, String shellTransactionId, String stageId, String previousStageId,
			String underFrameNumber, String shellNumber, String shellType, Date assemblyStartDate,
			Date expectedExitDate, Date assemblyEndDate, Date assemblyDispatchDate, String transactionDate,
			String transactionUser, String remarks, String exitRemarks, String lateRemarks, Integer asignedFlag,
			Date receiptatNextStage, String sideWallMakePp, String sideWallMakeNpp, String sideWallNoPp,
			String sideWallNoNpp, String roofMake, String roofNo, String lavsidewallMake1, String lavsidewallMake2,
			String lavsidewallMake3, String lavsidewallMake4, String lavsidewallNo1, String lavsidewallNo2,
			String lavsidewallNo3, String lavsidewallNo4, String endwallMakePp, String endwallMakeNpp,
			String endwallNoPp, String endwallNoNpp, Integer endwallSipFlag, Integer roofSipFlag,
			Integer underframeSipFlag, Integer sidewallSipFlag, Integer lavsidewallSipFlag, Integer stage1SipFlag,
			Integer stage2SipFlag, Integer stage3SipFlag, Integer stage4SipFlag, Integer finalIspectionReportFlag,
			Integer checkListFlag, Integer testingClearanceMemoFlag, String testingClearanceMemoDocNo,
			Date testingClearanceMemoDate, String testingClearanceMemoStatus, String testingClearanceMemoRemark,
			String waterTankBkt1, String waterTankBkt2, String waterTankBkt3, String waterTankBkt4,
			String cbcFittedByPp, String cbcFittedByNpp, String frntPrtMakePp, String frntPrtMakeNpp,
			String frntPrtNoPp, String frntPrtNoNpp, String cbCMakePp, String cbCMakeNpp, String cbCNoPp,
			String cbCNoNpp, String underframeMakePp, String underframeMakeNpp, String underframeNoPp,
			String underframeNoNpp, String underframeCompleteMake, String underframeCompleteNo,
			String sideDoorMakeNoLeft, String sideDoorMakeNoRight, String roofAcAssemblyMakeNoPp,
			String roofAcAssemblyMakeNoNpp, String wtccMakeNoPp, String wtccMakeNoNpp, String slidingDoorMakeNoLeft,
			String slidingDoorMakeNoRight, String shellAssembledBy, String jigNo, Integer assemblySipFlag) {
		super();
		this.shellAssetId = shellAssetId;
		this.shellTransactionId = shellTransactionId;
		this.stageId = stageId;
		this.previousStageId = previousStageId;
		this.underFrameNumber = underFrameNumber;
		this.shellNumber = shellNumber;
		this.shellType = shellType;
		this.assemblyStartDate = assemblyStartDate;
		this.expectedExitDate = expectedExitDate;
		this.assemblyEndDate = assemblyEndDate;
		this.assemblyDispatchDate = assemblyDispatchDate;
		this.transactionDate = transactionDate;
		this.transactionUser = transactionUser;
		this.remarks = remarks;
		this.exitRemarks = exitRemarks;
		this.lateRemarks = lateRemarks;
		this.asignedFlag = asignedFlag;
		this.receiptatNextStage = receiptatNextStage;
		this.sideWallMakePp = sideWallMakePp;
		this.sideWallMakeNpp = sideWallMakeNpp;
		this.sideWallNoPp = sideWallNoPp;
		this.sideWallNoNpp = sideWallNoNpp;
		this.roofMake = roofMake;
		this.roofNo = roofNo;
		this.lavsidewallMake1 = lavsidewallMake1;
		this.lavsidewallMake2 = lavsidewallMake2;
		this.lavsidewallMake3 = lavsidewallMake3;
		this.lavsidewallMake4 = lavsidewallMake4;
		this.lavsidewallNo1 = lavsidewallNo1;
		this.lavsidewallNo2 = lavsidewallNo2;
		this.lavsidewallNo3 = lavsidewallNo3;
		this.lavsidewallNo4 = lavsidewallNo4;
		this.endwallMakePp = endwallMakePp;
		this.endwallMakeNpp = endwallMakeNpp;
		this.endwallNoPp = endwallNoPp;
		this.endwallNoNpp = endwallNoNpp;
		this.endwallSipFlag = endwallSipFlag;
		this.roofSipFlag = roofSipFlag;
		this.underframeSipFlag = underframeSipFlag;
		this.sidewallSipFlag = sidewallSipFlag;
		this.lavsidewallSipFlag = lavsidewallSipFlag;
		this.stage1SipFlag = stage1SipFlag;
		this.stage2SipFlag = stage2SipFlag;
		this.stage3SipFlag = stage3SipFlag;
		this.stage4SipFlag = stage4SipFlag;
		this.finalIspectionReportFlag = finalIspectionReportFlag;
		this.checkListFlag = checkListFlag;
		this.testingClearanceMemoFlag = testingClearanceMemoFlag;
		this.testingClearanceMemoDocNo = testingClearanceMemoDocNo;
		this.testingClearanceMemoDate = testingClearanceMemoDate;
		this.testingClearanceMemoStatus = testingClearanceMemoStatus;
		this.testingClearanceMemoRemark = testingClearanceMemoRemark;
		this.waterTankBkt1 = waterTankBkt1;
		this.waterTankBkt2 = waterTankBkt2;
		this.waterTankBkt3 = waterTankBkt3;
		this.waterTankBkt4 = waterTankBkt4;
		this.cbcFittedByPp = cbcFittedByPp;
		this.cbcFittedByNpp = cbcFittedByNpp;
		this.frntPrtMakePp = frntPrtMakePp;
		this.frntPrtMakeNpp = frntPrtMakeNpp;
		this.frntPrtNoPp = frntPrtNoPp;
		this.frntPrtNoNpp = frntPrtNoNpp;
		this.cbCMakePp = cbCMakePp;
		this.cbCMakeNpp = cbCMakeNpp;
		this.cbCNoPp = cbCNoPp;
		this.cbCNoNpp = cbCNoNpp;
		this.underframeMakePp = underframeMakePp;
		this.underframeMakeNpp = underframeMakeNpp;
		this.underframeNoPp = underframeNoPp;
		this.underframeNoNpp = underframeNoNpp;
		this.underframeCompleteMake = underframeCompleteMake;
		this.underframeCompleteNo = underframeCompleteNo;
		this.sideDoorMakeNoLeft = sideDoorMakeNoLeft;
		this.sideDoorMakeNoRight = sideDoorMakeNoRight;
		this.roofAcAssemblyMakeNoPp = roofAcAssemblyMakeNoPp;
		this.roofAcAssemblyMakeNoNpp = roofAcAssemblyMakeNoNpp;
		this.wtccMakeNoPp = wtccMakeNoPp;
		this.wtccMakeNoNpp = wtccMakeNoNpp;
		this.slidingDoorMakeNoLeft = slidingDoorMakeNoLeft;
		this.slidingDoorMakeNoRight = slidingDoorMakeNoRight;
		this.shellAssembledBy = shellAssembledBy;
		this.jigNo = jigNo;
		this.assemblySipFlag = assemblySipFlag;
	}













	public String getEndwallNoPp() {
		return endwallNoPp;
	}

	public void setEndwallNoPp(String endwallNoPp) {
		this.endwallNoPp = endwallNoPp;
	}

	public String getEndwallNoNpp() {
		return endwallNoNpp;
	}

	public void setEndwallNoNpp(String endwallNoNpp) {
		this.endwallNoNpp = endwallNoNpp;
	}

	public Integer getShellAssetId() {
		return shellAssetId;
	}





	public void setShellAssetId(Integer shellAssetId) {
		this.shellAssetId = shellAssetId;
	}





	public String getShellTransactionId() {
		return shellTransactionId;
	}





	public void setShellTransactionId(String shellTransactionId) {
		this.shellTransactionId = shellTransactionId;
	}





	public String getStageId() {
		return stageId;
	}





	public void setStageId(String stageId) {
		this.stageId = stageId;
	}





	public String getPreviousStageId() {
		return previousStageId;
	}





	public void setPreviousStageId(String previousStageId) {
		this.previousStageId = previousStageId;
	}





	public String getUnderFrameNumber() {
		return underFrameNumber;
	}





	public void setUnderFrameNumber(String underFrameNumber) {
		this.underFrameNumber = underFrameNumber;
	}





	public String getShellNumber() {
		return shellNumber;
	}





	public void setShellNumber(String shellNumber) {
		this.shellNumber = shellNumber;
	}





	public String getShellType() {
		return shellType;
	}





	public void setShellType(String shellType) {
		this.shellType = shellType;
	}





	public Date getAssemblyStartDate() {
		return assemblyStartDate;
	}





	public void setAssemblyStartDate(Date assemblyStartDate) {
		this.assemblyStartDate = assemblyStartDate;
	}





	public Date getExpectedExitDate() {
		return expectedExitDate;
	}





	public void setExpectedExitDate(Date expectedExitDate) {
		this.expectedExitDate = expectedExitDate;
	}





	public Date getAssemblyEndDate() {
		return assemblyEndDate;
	}





	public void setAssemblyEndDate(Date assemblyEndDate) {
		this.assemblyEndDate = assemblyEndDate;
	}





	public Date getAssemblyDispatchDate() {
		return assemblyDispatchDate;
	}





	public void setAssemblyDispatchDate(Date assemblyDispatchDate) {
		this.assemblyDispatchDate = assemblyDispatchDate;
	}





	public String getTransactionDate() {
		return transactionDate;
	}





	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}





	public String getTransactionUser() {
		return transactionUser;
	}





	public void setTransactionUser(String transactionUser) {
		this.transactionUser = transactionUser;
	}





	public String getRemarks() {
		return remarks;
	}





	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}





	public String getExitRemarks() {
		return exitRemarks;
	}





	public void setExitRemarks(String exitRemarks) {
		this.exitRemarks = exitRemarks;
	}





	public String getLateRemarks() {
		return lateRemarks;
	}





	public void setLateRemarks(String lateRemarks) {
		this.lateRemarks = lateRemarks;
	}





	public Integer getAsignedFlag() {
		return asignedFlag;
	}





	public void setAsignedFlag(Integer asignedFlag) {
		this.asignedFlag = asignedFlag;
	}





	public Date getReceiptatNextStage() {
		return receiptatNextStage;
	}





	public void setReceiptatNextStage(Date receiptatNextStage) {
		this.receiptatNextStage = receiptatNextStage;
	}








	public String getCbcFittedByPp() {
		return cbcFittedByPp;
	}





	public void setCbcFittedByPp(String cbcFittedByPp) {
		this.cbcFittedByPp = cbcFittedByPp;
	}





	public String getCbcFittedByNpp() {
		return cbcFittedByNpp;
	}





	public void setCbcFittedByNpp(String cbcFittedByNpp) {
		this.cbcFittedByNpp = cbcFittedByNpp;
	}



	public String getSideWallMakePp() {
		return sideWallMakePp;
	}

	public void setSideWallMakePp(String sideWallMakePp) {
		this.sideWallMakePp = sideWallMakePp;
	}

	public String getSideWallMakeNpp() {
		return sideWallMakeNpp;
	}

	public void setSideWallMakeNpp(String sideWallMakeNpp) {
		this.sideWallMakeNpp = sideWallMakeNpp;
	}

	public String getSideWallNoPp() {
		return sideWallNoPp;
	}

	public void setSideWallNoPp(String sideWallNoPp) {
		this.sideWallNoPp = sideWallNoPp;
	}

	public String getSideWallNoNpp() {
		return sideWallNoNpp;
	}

	public void setSideWallNoNpp(String sideWallNoNpp) {
		this.sideWallNoNpp = sideWallNoNpp;
	}

	public String getFrntPrtMakePp() {
		return frntPrtMakePp;
	}



	public void setFrntPrtMakePp(String frntPrtMakePp) {
		this.frntPrtMakePp = frntPrtMakePp;
	}



	public String getFrntPrtMakeNpp() {
		return frntPrtMakeNpp;
	}



	public void setFrntPrtMakeNpp(String frntPrtMakeNpp) {
		this.frntPrtMakeNpp = frntPrtMakeNpp;
	}



	public String getFrntPrtNoPp() {
		return frntPrtNoPp;
	}



	public void setFrntPrtNoPp(String frntPrtNoPp) {
		this.frntPrtNoPp = frntPrtNoPp;
	}



	public String getFrntPrtNoNpp() {
		return frntPrtNoNpp;
	}



	public void setFrntPrtNoNpp(String frntPrtNoNpp) {
		this.frntPrtNoNpp = frntPrtNoNpp;
	}



	public String getCbCMakePp() {
		return cbCMakePp;
	}



	public void setCbCMakePp(String cbCMakePp) {
		this.cbCMakePp = cbCMakePp;
	}



	public String getCbCMakeNpp() {
		return cbCMakeNpp;
	}



	public void setCbCMakeNpp(String cbCMakeNpp) {
		this.cbCMakeNpp = cbCMakeNpp;
	}



	public String getCbCNoPp() {
		return cbCNoPp;
	}



	public void setCbCNoPp(String cbCNoPp) {
		this.cbCNoPp = cbCNoPp;
	}



	public String getCbCNoNpp() {
		return cbCNoNpp;
	}



	public void setCbCNoNpp(String cbCNoNpp) {
		this.cbCNoNpp = cbCNoNpp;
	}



	public String getUnderframeMakePp() {
		return underframeMakePp;
	}



	public void setUnderframeMakePp(String underframeMakePp) {
		this.underframeMakePp = underframeMakePp;
	}



	public String getUnderframeMakeNpp() {
		return underframeMakeNpp;
	}



	public void setUnderframeMakeNpp(String underframeMakeNpp) {
		this.underframeMakeNpp = underframeMakeNpp;
	}



	public String getUnderframeNoPp() {
		return underframeNoPp;
	}



	public void setUnderframeNoPp(String underframeNoPp) {
		this.underframeNoPp = underframeNoPp;
	}



	public String getUnderframeNoNpp() {
		return underframeNoNpp;
	}



	public void setUnderframeNoNpp(String underframeNoNpp) {
		this.underframeNoNpp = underframeNoNpp;
	}



	public String getRoofMake() {
		return roofMake;
	}





	public void setRoofMake(String roofMake) {
		this.roofMake = roofMake;
	}





	public String getEndwallMakePp() {
		return endwallMakePp;
	}





	public void setEndwallMakePp(String endwallMakePp) {
		this.endwallMakePp = endwallMakePp;
	}





	public String getEndwallMakeNpp() {
		return endwallMakeNpp;
	}





	public void setEndwallMakeNpp(String endwallMakeNpp) {
		this.endwallMakeNpp = endwallMakeNpp;
	}





	public Integer getEndwallSipFlag() {
		return endwallSipFlag;
	}





	public void setEndwallSipFlag(Integer endwallSipFlag) {
		this.endwallSipFlag = endwallSipFlag;
	}





	public Integer getRoofSipFlag() {
		return roofSipFlag;
	}





	public void setRoofSipFlag(Integer roofSipFlag) {
		this.roofSipFlag = roofSipFlag;
	}





	public Integer getUnderframeSipFlag() {
		return underframeSipFlag;
	}





	public void setUnderframeSipFlag(Integer underframeSipFlag) {
		this.underframeSipFlag = underframeSipFlag;
	}





	public Integer getSidewallSipFlag() {
		return sidewallSipFlag;
	}





	public void setSidewallSipFlag(Integer sidewallSipFlag) {
		this.sidewallSipFlag = sidewallSipFlag;
	}





	public Integer getLavsidewallSipFlag() {
		return lavsidewallSipFlag;
	}





	public void setLavsidewallSipFlag(Integer lavsidewallSipFlag) {
		this.lavsidewallSipFlag = lavsidewallSipFlag;
	}





	public Integer getStage1SipFlag() {
		return stage1SipFlag;
	}





	public void setStage1SipFlag(Integer stage1SipFlag) {
		this.stage1SipFlag = stage1SipFlag;
	}





	public Integer getStage2SipFlag() {
		return stage2SipFlag;
	}





	public void setStage2SipFlag(Integer stage2SipFlag) {
		this.stage2SipFlag = stage2SipFlag;
	}





	public Integer getStage3SipFlag() {
		return stage3SipFlag;
	}





	public void setStage3SipFlag(Integer stage3SipFlag) {
		this.stage3SipFlag = stage3SipFlag;
	}





	public Integer getStage4SipFlag() {
		return stage4SipFlag;
	}





	public void setStage4SipFlag(Integer stage4SipFlag) {
		this.stage4SipFlag = stage4SipFlag;
	}





	public Integer getFinalIspectionReportFlag() {
		return finalIspectionReportFlag;
	}





	public void setFinalIspectionReportFlag(Integer finalIspectionReportFlag) {
		this.finalIspectionReportFlag = finalIspectionReportFlag;
	}





	public Integer getCheckListFlag() {
		return checkListFlag;
	}





	public void setCheckListFlag(Integer checkListFlag) {
		this.checkListFlag = checkListFlag;
	}





	public Integer getTestingClearanceMemoFlag() {
		return testingClearanceMemoFlag;
	}





	public void setTestingClearanceMemoFlag(Integer testingClearanceMemoFlag) {
		this.testingClearanceMemoFlag = testingClearanceMemoFlag;
	}





	public String getTestingClearanceMemoDocNo() {
		return testingClearanceMemoDocNo;
	}





	public void setTestingClearanceMemoDocNo(String testingClearanceMemoDocNo) {
		this.testingClearanceMemoDocNo = testingClearanceMemoDocNo;
	}





	public Date getTestingClearanceMemoDate() {
		return testingClearanceMemoDate;
	}





	public void setTestingClearanceMemoDate(Date testingClearanceMemoDate) {
		this.testingClearanceMemoDate = testingClearanceMemoDate;
	}





	public String getTestingClearanceMemoStatus() {
		return testingClearanceMemoStatus;
	}





	public void setTestingClearanceMemoStatus(String testingClearanceMemoStatus) {
		this.testingClearanceMemoStatus = testingClearanceMemoStatus;
	}





	public String getTestingClearanceMemoRemark() {
		return testingClearanceMemoRemark;
	}





	public void setTestingClearanceMemoRemark(String testingClearanceMemoRemark) {
		this.testingClearanceMemoRemark = testingClearanceMemoRemark;
	}





	public String getWaterTankBkt1() {
		return waterTankBkt1;
	}





	public void setWaterTankBkt1(String waterTankBkt1) {
		this.waterTankBkt1 = waterTankBkt1;
	}





	public String getWaterTankBkt2() {
		return waterTankBkt2;
	}





	public void setWaterTankBkt2(String waterTankBkt2) {
		this.waterTankBkt2 = waterTankBkt2;
	}





	public String getWaterTankBkt3() {
		return waterTankBkt3;
	}





	public void setWaterTankBkt3(String waterTankBkt3) {
		this.waterTankBkt3 = waterTankBkt3;
	}





	public String getWaterTankBkt4() {
		return waterTankBkt4;
	}





	public void setWaterTankBkt4(String waterTankBkt4) {
		this.waterTankBkt4 = waterTankBkt4;
	}





	public String getSideDoorMakeNoLeft() {
		return sideDoorMakeNoLeft;
	}





	public void setSideDoorMakeNoLeft(String sideDoorMakeNoLeft) {
		this.sideDoorMakeNoLeft = sideDoorMakeNoLeft;
	}





	public String getSideDoorMakeNoRight() {
		return sideDoorMakeNoRight;
	}





	public void setSideDoorMakeNoRight(String sideDoorMakeNoRight) {
		this.sideDoorMakeNoRight = sideDoorMakeNoRight;
	}





	public String getRoofAcAssemblyMakeNoPp() {
		return roofAcAssemblyMakeNoPp;
	}





	public void setRoofAcAssemblyMakeNoPp(String roofAcAssemblyMakeNoPp) {
		this.roofAcAssemblyMakeNoPp = roofAcAssemblyMakeNoPp;
	}





	public String getRoofAcAssemblyMakeNoNpp() {
		return roofAcAssemblyMakeNoNpp;
	}





	public void setRoofAcAssemblyMakeNoNpp(String roofAcAssemblyMakeNoNpp) {
		this.roofAcAssemblyMakeNoNpp = roofAcAssemblyMakeNoNpp;
	}





	public String getWtccMakeNoPp() {
		return wtccMakeNoPp;
	}





	public void setWtccMakeNoPp(String wtccMakeNoPp) {
		this.wtccMakeNoPp = wtccMakeNoPp;
	}





	public String getWtccMakeNoNpp() {
		return wtccMakeNoNpp;
	}





	public void setWtccMakeNoNpp(String wtccMakeNoNpp) {
		this.wtccMakeNoNpp = wtccMakeNoNpp;
	}





	public String getSlidingDoorMakeNoLeft() {
		return slidingDoorMakeNoLeft;
	}





	public void setSlidingDoorMakeNoLeft(String slidingDoorMakeNoLeft) {
		this.slidingDoorMakeNoLeft = slidingDoorMakeNoLeft;
	}





	public String getSlidingDoorMakeNoRight() {
		return slidingDoorMakeNoRight;
	}





	public void setSlidingDoorMakeNoRight(String slidingDoorMakeNoRight) {
		this.slidingDoorMakeNoRight = slidingDoorMakeNoRight;
	}





	public String getShellAssembledBy() {
		return shellAssembledBy;
	}





	public void setShellAssembledBy(String shellAssembledBy) {
		this.shellAssembledBy = shellAssembledBy;
	}





	public String getJigNo() {
		return jigNo;
	}





	public void setJigNo(String jigNo) {
		this.jigNo = jigNo;
	}





	public Integer getAssemblySipFlag() {
		return assemblySipFlag;
	}





	public void setAssemblySipFlag(Integer assemblySipFlag) {
		this.assemblySipFlag = assemblySipFlag;
	}





	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public String getRoofNo() {
		return roofNo;
	}


	public void setRoofNo(String roofNo) {
		this.roofNo = roofNo;
	}

	public String getLavsidewallMake1() {
		return lavsidewallMake1;
	}

	public void setLavsidewallMake1(String lavsidewallMake1) {
		this.lavsidewallMake1 = lavsidewallMake1;
	}

	public String getLavsidewallMake2() {
		return lavsidewallMake2;
	}

	public void setLavsidewallMake2(String lavsidewallMake2) {
		this.lavsidewallMake2 = lavsidewallMake2;
	}

	public String getLavsidewallMake3() {
		return lavsidewallMake3;
	}

	public void setLavsidewallMake3(String lavsidewallMake3) {
		this.lavsidewallMake3 = lavsidewallMake3;
	}

	public String getLavsidewallMake4() {
		return lavsidewallMake4;
	}

	public void setLavsidewallMake4(String lavsidewallMake4) {
		this.lavsidewallMake4 = lavsidewallMake4;
	}

	public String getLavsidewallNo1() {
		return lavsidewallNo1;
	}

	public void setLavsidewallNo1(String lavsidewallNo1) {
		this.lavsidewallNo1 = lavsidewallNo1;
	}

	public String getLavsidewallNo2() {
		return lavsidewallNo2;
	}

	public void setLavsidewallNo2(String lavsidewallNo2) {
		this.lavsidewallNo2 = lavsidewallNo2;
	}

	public String getLavsidewallNo3() {
		return lavsidewallNo3;
	}

	public void setLavsidewallNo3(String lavsidewallNo3) {
		this.lavsidewallNo3 = lavsidewallNo3;
	}

	public String getLavsidewallNo4() {
		return lavsidewallNo4;
	}

	public void setLavsidewallNo4(String lavsidewallNo4) {
		this.lavsidewallNo4 = lavsidewallNo4;
	}


	public String getUnderframeCompleteMake() {
		return underframeCompleteMake;
	}


	public void setUnderframeCompleteMake(String underframeCompleteMake) {
		this.underframeCompleteMake = underframeCompleteMake;
	}


	public String getUnderframeCompleteNo() {
		return underframeCompleteNo;
	}


	public void setUnderframeCompleteNo(String underframeCompleteNo) {
		this.underframeCompleteNo = underframeCompleteNo;
	}




	
}
