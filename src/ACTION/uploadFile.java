package ACTION;

import java.io.File;
import org.apache.commons.io.FileUtils;
import java.io.IOException; 
import dao.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.text.*;
import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.*;
import javax.servlet.ServletContext;
public class uploadFile extends ActionSupport {
   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
   private File myFile;
   private String myFileContentType;
   private String myFileFileName;
   private String destPath;
   private String dn;
   private String des;
   private String docid;
   private String ver;
   private String Author;
   private String Doctype;
  
   public String execute() {
      /* Copy file to a safe location */
     

      try {
    	  if ((myFileContentType != null) && (myFileContentType.indexOf("multipart/form-data") >= 0)) {
    		  
    	  }
         System.out.println("Src File name: " + myFile);
         System.out.println("Dst File name: " + myFileFileName);
         System.out.println("dn: " + dn);
         System.out.println("Docid: " + docid);
         System.out.println("File ver: " + ver);
         System.out.println(" File Author: " + Author);
         System.out.println(" File Doctype: " + Doctype);
         String os=System.getProperty("os.name");
         if(os.startsWith("Windows")){
        	 File checkfile = new File("C:/dms");
				boolean fileExists = checkfile.exists();
				if(!fileExists)
				{
				System.out.println("Dir does not exist");
				File createfile = new File("C:/dms");
				boolean dirCreated = createfile.mkdir();
				if(dirCreated)
				{
					System.out.println("Dir created");
					
				}
				else
				{
					System.out.println("No Dir created");
				}
				}
			
				 destPath = "C:/dms";
         }
         File destFile  = new File(destPath, myFileFileName);
         FileUtils.copyFile(myFile, destFile);
         DbConnection db=new DbConnection();
     	Connection con=db.getConnection(); 
     		Statement st1=con.createStatement();
     		Statement st2=con.createStatement();
     		Statement st3=con.createStatement();
     		int formDataLength = myFileContentType.length();
     		Date s1=new Date();
       		SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
     		//String author=(String)session.getAttribute("userid");
       		//int doc=Integer.parseInt(docid);
       		ResultSet rs=st1.executeQuery("select docname,version from public.documentload where author='"+Author+"'");
    		String s=dn+ver;
    		String flag="true";
    		while(rs.next()){
    			String filepath=rs.getString("docname");
    			String vers=rs.getString("version");
    			String x=filepath+vers;
    			if(x.equals(s)){
    				flag="false";
    				
    				return "error";
    			}
    			}
    				
    		
    		if(flag=="true"){			
         st1.executeUpdate("insert into public.documentload values('"+dn+"','"+des+"','"+docid+"','"+ver+"','"+Author+"','"+formDataLength+"','"+f.format(s1) +"','created','"+myFileFileName+"','"+Doctype+"')");	
			st1.executeUpdate("insert into public.noting_trans(docid,noting_detail,userid,createdate) values('"+docid+"','"+des+"','"+Author+"','"+f.format(s1)+"')");
			// st1.executeUpdate("insert into public.noting_ids values('"+su+"')");
			
			if(Doctype.equalsIgnoreCase("LearningFile")){
			   st3.executeUpdate("insert into public.documentshared values('"+docid+"','All','"+Author+"','"+ f.format(s1)+"','shared','"+Doctype+"','No remarks')");	
			}
			ResultSet rs1=st2.executeQuery("select docid from public.documentload where docname='"+dn+"' and version='"+ver+"' and author='"+Author+"'");
			rs1.next();
			String id=rs1.getString("docid");
			st1.executeUpdate("insert into public.docids values('"+id+"')");
    		}
         
  
      } catch(IOException e) {
         e.printStackTrace();
         return "error";
      } catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		  return "error";
	}
     

      return "success";
   }
   
   public File getMyFile() {
      return myFile;
   }
   
   public void setMyFile(File myFile) {
      this.myFile = myFile;
   }
   
   public String getMyFileContentType() {
      return myFileContentType;
   }
   
   public void setMyFileContentType(String myFileContentType) {
      this.myFileContentType = myFileContentType;
   }
   
   public String getMyFileFileName() {
      return myFileFileName;
   }
   
   public void setMyFileFileName(String myFileFileName) {
      this.myFileFileName = myFileFileName;
   }

public String getDestPath() {
	return destPath;
}

public void setDestPath(String destPath) {
	this.destPath = destPath;
}

public String getDn() {
	return dn;
}

public void setDn(String dn) {
	this.dn = dn;
}

public String getDes() {
	return des;
}

public void setDes(String des) {
	this.des = des;
}

public String getDocid() {
	return docid;
}

public void setDocid(String docid) {
	this.docid = docid;
}

public String getVer() {
	return ver;
}

public void setVer(String ver) {
	this.ver = ver;
}

public String getAuthor() {
	return Author;
}

public void setAuthor(String author) {
	Author = author;
}

public String getDoctype() {
	return Doctype;
}

public void setDoctype(String doctype) {
	Doctype = doctype;
}
}