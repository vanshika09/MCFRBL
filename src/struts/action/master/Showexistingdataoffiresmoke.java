package struts.action.master;
import org.hibernate.Session;


import beans.FurnishingTransaction;
import beans.PaintTransaction;
import beans.ShellTransaction;
import hibernateConnect.HibernateConfig;


public class  Showexistingdataoffiresmoke{
	private String furnishingAssetId;
	private String docnofiresmoke;
	private String shelltype;
	private String shellno;
	private String coachtype;
	private String coachno;
	private String furno;
	
	
	public String fetchdata()
	{
		Integer furnishingAssetIdAsInt=Integer.parseInt(furnishingAssetId);
		Session session=null;
		
		try
		{
			session=HibernateConfig.getSession();
			FurnishingTransaction furnishingTransaction= (FurnishingTransaction) session.get(FurnishingTransaction.class,furnishingAssetIdAsInt);
			docnofiresmoke="MCF/RBL/QMF 7002A Rev-01 dated-31-05-19";		
			
			coachno=furnishingTransaction.getCoachNumber();
			System.out.println("Coach No:-"+coachno);
			coachtype=furnishingTransaction.getCoachType(); 
			System.out.println("Coach Type:-"+coachtype);
		    
			Integer shellId=furnishingTransaction.getShellAssetId();
			ShellTransaction shellTransaction=(ShellTransaction) session.get(ShellTransaction.class, shellId);
			
			shellno=shellTransaction.getShellNumber();
			System.out.println("shellno :-"+ shellno);
			shelltype=shellTransaction.getShellType();
			System.out.println("shelltype :-"+ shelltype);
		    
			Integer paintId=furnishingTransaction.getPaintAssetId();
			PaintTransaction paintTran= (PaintTransaction) session.get(PaintTransaction.class,paintId);
			furno=paintTran.getFurnishingNumber();
			
			
			
			
			
			return "success";
		}
		catch(Exception Ex)
		{
			Ex.printStackTrace();
			return "error";
		}
		finally
		{
			if(session!=null)
			{
				session.close();
			}
		}
		}


	public String getFurnishingAssetId() {
		return furnishingAssetId;
	}


	public void setFurnishingAssetId(String furnishingAssetId) {
		this.furnishingAssetId = furnishingAssetId;
	}


	

	public String getDocnofiresmoke() {
		return docnofiresmoke;
	}


	public void setDocnofiresmoke(String docnofiresmoke) {
		this.docnofiresmoke = docnofiresmoke;
	}


	public String getShelltype() {
		return shelltype;
	}


	public void setShelltype(String shelltype) {
		this.shelltype = shelltype;
	}


	public String getShellno() {
		return shellno;
	}


	public void setShellno(String shellno) {
		this.shellno = shellno;
	}


	public String getCoachtype() {
		return coachtype;
	}


	public void setCoachtype(String coachtype) {
		this.coachtype = coachtype;
	}


	public String getCoachno() {
		return coachno;
	}


	public void setCoachno(String coachno) {
		this.coachno = coachno;
	}


	public String getFurno() {
		return furno;
	}


	public void setFurno(String furno) {
		this.furno = furno;
	}

		
}
