package ACTION;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import beans.CustomPeartChart;
import common.DateUtil;
import dao.DbConnection;
public class PertClass {
public String StartDate;
public String EndDate;
public List <CustomPeartChart>   pertChartList;

public String getPertData() throws SQLException
{
	DbConnection db=new DbConnection();
	
	Connection con=db.getConnection(); 
	try
	{
	Date startDateasDate=DateUtil.convertToDate(StartDate);
	Date endDateasDate=DateUtil.convertToDate(EndDate);
	Statement st=con.createStatement();
	pertChartList =new ArrayList<CustomPeartChart>();
	
	String query="select 1 as key_field, 'Start' as shop, 0 as min_time, 0 as max_time, 0 as std_dev, 0 as avg_time, 0 as total_prod, 0 as work_in_prog UNION select 2 as key_field, 'Wheel' as shop, MIN (assembly_dispatch_date::date-assembly_start_date:: date) as min_time, MAX (assembly_dispatch_date::date-assembly_start_date:: date) as max_time,  ROUND(STDDEV (assembly_dispatch_date::date-assembly_start_date:: date),2) as std_dev,  ROUND (AVG(assembly_dispatch_date::date-assembly_start_date:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from wheelset_tran B where B.assembly_dispatch_date is null and B.assembly_start_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from wheelset_tran where assembly_dispatch_date is not null and assembly_dispatch_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select 3 as key_field, 'Bogie' as shop, MIN (assembly_exit_date::date-assembly_start_date:: date) as min_time, MAX (assembly_exit_date::date-assembly_start_date:: date) as max_time,  ROUND(STDDEV (assembly_exit_date::date-assembly_start_date:: date),2) as std_dev,  ROUND (AVG(assembly_exit_date::date-assembly_start_date:: date), 2) as avg_time, count(*) as total_prod,(select count(*) as work_in_progress from bogieset_trans B where B.assembly_exit_date is null and B.assembly_start_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from bogieset_trans where assembly_exit_date is not null and assembly_exit_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select 4 as key_field, 'Shell' as shop, MIN (assembly_dispatch_date::date-assembly_start_date:: date) as min_time, MAX (assembly_dispatch_date::date-assembly_start_date:: date) as max_time,  ROUND(STDDEV (assembly_dispatch_date::date-assembly_start_date:: date),2) as std_dev,  ROUND (AVG(assembly_dispatch_date::date-assembly_start_date:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from shell_tran B where B.assembly_dispatch_date is null and B.assembly_start_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from shell_tran where assembly_dispatch_date is not null and assembly_dispatch_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select  5 as key_field,'Paint' as shop, MIN (assembly_dispatch_date::date-assembly_start_date:: date) as min_time, MAX (assembly_dispatch_date::date-assembly_start_date:: date) as max_time,  ROUND(STDDEV (assembly_dispatch_date::date-assembly_start_date:: date),2) as std_dev,  ROUND (AVG(assembly_dispatch_date::date-assembly_start_date:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from paint_tran B where B.assembly_dispatch_date is null and B.assembly_start_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from paint_tran where assembly_dispatch_date is not null and assembly_dispatch_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select 6 as key_field,'Furnishing' as shop, MIN (dispatch_date_in_quality::date-assembly_start_date:: date) as min_time, MAX (dispatch_date_in_quality::date-assembly_start_date:: date) as max_time,  ROUND(STDDEV (dispatch_date_in_quality::date-assembly_start_date:: date),2) as std_dev,  ROUND (AVG(dispatch_date_in_quality::date-assembly_start_date:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from furnishing_tran B where B.dispatch_date_in_quality is null and B.assembly_start_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from furnishing_tran where dispatch_date_in_quality is not null and dispatch_date_in_quality BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select 7 as key_field, 'Quality' as shop, MIN (coach_dispatch_date::date-receiptdate_at_quality:: date) as min_time, MAX (coach_dispatch_date::date-receiptdate_at_quality:: date) as max_time,  ROUND(STDDEV (coach_dispatch_date::date-receiptdate_at_quality:: date),2) as std_dev,  ROUND (AVG(coach_dispatch_date::date-receiptdate_at_quality:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from furnishing_tran B where B.coach_dispatch_date is null and B.receiptdate_at_quality BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from furnishing_tran where coach_dispatch_date is not null and coach_dispatch_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' union select 8 as key_field, 'GateOut' as shop, MIN (gate_out_date::date-coach_dispatch_date:: date) as min_time, MAX (gate_out_date::date-coach_dispatch_date:: date) as max_time,  ROUND(STDDEV (gate_out_date::date-coach_dispatch_date:: date),2) as std_dev,  ROUND (AVG(gate_out_date::date-coach_dispatch_date:: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from furnishing_tran B where B.gate_out_date is null and B.coach_dispatch_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from furnishing_tran where gate_out_date is not null and gate_out_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' UNION select 9 as key_field, 'Cyclic Time' as shop, MIN (gate_out_date::date-prod_cycl_strt_date(furnishing_asset_id):: date) as min_time, MAX (gate_out_date::date-prod_cycl_strt_date(furnishing_asset_id):: date) as max_time,  ROUND(STDDEV (gate_out_date::date-prod_cycl_strt_date(furnishing_asset_id):: date),2) as std_dev,  ROUND (AVG(gate_out_date::date-prod_cycl_strt_date(furnishing_asset_id):: date), 2) as avg_time, count(*) as total_prod, (select count(*) as work_in_progress from furnishing_tran B where B.gate_out_date is null and prod_cycl_strt_date(B.furnishing_asset_id) BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' ) as work_in_prog from furnishing_tran where gate_out_date is not null and gate_out_date BETWEEN '"+startDateasDate+"' AND '"+endDateasDate+"' order by key_field";
	System.out.println(query);
	ResultSet res=st.executeQuery(query);
	while(res.next())
	{
		Integer key=Integer.parseInt(res.getString(1));
		String secColumn=res.getString(2);
		if(secColumn==null) {secColumn="N/A";}
		String thirdColumn=res.getString(3);
		if(thirdColumn==null) {thirdColumn="N/A";}
		String forthColumn=res.getString(4);
		if(forthColumn==null) {forthColumn="N/A";}
		String fifthColumn=res.getString(5);
		if(fifthColumn==null) {fifthColumn="N/A";}
		String sixthColumn=res.getString(6);
		if(sixthColumn==null) {sixthColumn="N/A";}
		String seventhColumn=res.getString(7);
		if(seventhColumn==null) {seventhColumn="N/A";}
		String eigthColumn=res.getString(8);
		if(eigthColumn==null) {eigthColumn="N/A";}
		CustomPeartChart pChart=new CustomPeartChart();
		pChart.setKey(key);
		pChart.setText(secColumn);
		pChart.setEarlyStart(thirdColumn);
		pChart.setLength(forthColumn);
		pChart.setEarlyFinish(fifthColumn);
		pChart.setLateStart(sixthColumn);
		pChart.setSlack(seventhColumn);
		pChart.setLateFinish(eigthColumn);
		pChart.setCritical(true);
		pertChartList.add(pChart);
	}
	return "success";
}

catch(Exception ex)
{
	ex.printStackTrace();
	return null;
}
	finally
	{
		if(con!=null)
		{
		con.close();
		}
	}
}


public String getStartDate() {
	return StartDate;
}


public void setStartDate(String startDate) {
	StartDate = startDate;
}


public String getEndDate() {
	return EndDate;
}


public void setEndDate(String endDate) {
	EndDate = endDate;
}


public List<CustomPeartChart> getPertChartList() {
	return pertChartList;
}

public void setPertChartList(List<CustomPeartChart> pertChartList) {
	this.pertChartList = pertChartList;
}

}
