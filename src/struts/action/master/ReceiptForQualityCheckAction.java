package struts.action.master;

import java.text.SimpleDateFormat;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import beans.FurnishingTransaction;
import dao.DaoFurnishingProduction;
import hibernateConnect.HibernateConfig;

public class ReceiptForQualityCheckAction {
       
	   private Integer furnishingAssetId;
	   private String receiptDate;
	
	
	public String assignReceiptDate()
	{
		Session session=null;
		session = HibernateConfig.getSession();
		
		try {
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
//SubStagesMaster subStagesMaster= new SubStagesMaster();
FurnishingTransaction	furnishingTransaction= new	FurnishingTransaction();
//First row entry

Criteria cr = session.createCriteria(FurnishingTransaction.class);
cr.add(Restrictions.eq("furnishingAssetId", furnishingAssetId));

@SuppressWarnings("unchecked")
List<FurnishingTransaction> spList=(List<FurnishingTransaction>)cr.list();
furnishingTransaction=spList.get(0);
/*shellProgress.setSubstageId(stageId); 
shellProgress.setShellNumber(shellNumber);
*/
if(!("".equals(receiptDate))) { furnishingTransaction.setReceiptDateAtQuality(df.parse(receiptDate)); }

furnishingTransaction.setAssignedFlagQuality(1);

			DaoFurnishingProduction daoFurnishingProduction=new DaoFurnishingProduction();
			
			daoFurnishingProduction.updateFurnishingProgress(furnishingTransaction);
		
		
		return "success";
	}
		catch (Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
		finally{
			if(session!= null){
				System.out.println("--Inside dao.DaoAbnormality getAllAbnormaity() methods finally Block--");
				session.close();
			}			
		}
	}


	public Integer getFurnishingAssetId() {
		return furnishingAssetId;
	}


	public void setFurnishingAssetId(Integer furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}


	public String getReceiptDate() {
		return receiptDate;
	}


	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}
	
	
}
