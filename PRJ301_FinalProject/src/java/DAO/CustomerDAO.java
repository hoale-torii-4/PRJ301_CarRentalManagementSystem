/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Customer;
import mylib.DBUtils;

/**
 *
 * @author user
 */
public class CustomerDAO {
    public Customer checkLogin(String name, String phone){
        Customer rs=null;
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select custID,custName,phone,sex,cusAddress\n"
                      + "from dbo.Customer\n"
                      + "where custName = ? and phone=?";
              PreparedStatement st=cn.prepareStatement(sql);
              st.setString(1, name);
              st.setString(2, phone);
              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      int custid=table.getInt("custID");
                      String custname=table.getString("custName");
                      //String phone=""+table.getString("phone");
                      String sex=table.getString("sex");
                      String custadd=table.getString("cusAddress");
                      rs=new Customer(custid, custname, phone, sex, custadd);
                      
                  }
              }
          }
        
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rs;
    }
    public Customer getCustomer(int custID){
        Customer rs=null;
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select custID,custName,phone,sex,cusAddress\n"
                      + "from dbo.Customer\n"
                      + "where custID LIKE ?";
              PreparedStatement st=cn.prepareStatement(sql);
              st.setInt(1, custID);

              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      int custid=table.getInt("custID");
                      String custname=table.getString("custName");
                      String phone=""+table.getString("phone");
                      String sex=table.getString("sex");
                      String custadd=table.getString("cusAddress");
                      rs=new Customer(custid, custname, phone, sex, custadd);
                      
                  }
              }
          }
        
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rs;
    }
    public Customer getCustomerByName(String custName){
        Customer rs=null;
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select custID,phone,sex,cusAddress\n"
                      + "from dbo.Customer\n"
                      + "where custName LIKE ?";
              PreparedStatement st=cn.prepareStatement(sql);
              st.setString(1, custName);

              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      int custid=table.getInt("custID");
                      String phone=""+table.getString("phone");
                      String sex=table.getString("sex");
                      String custadd=table.getString("cusAddress");
                      rs=new Customer(custid, custName, phone, sex, custadd);
                      
                  }
              }
          }
        
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rs;
    }
    public ArrayList<Customer> getCustomers(){
        ArrayList<Customer> list=new ArrayList();
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select custID,custName,phone,sex,cusAddress\n"
                      + "from dbo.Customer\n";                    
              PreparedStatement st=cn.prepareStatement(sql);
              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      int custid=table.getInt("custID");
                      String custname=table.getString("custName");
                      String phone=""+table.getString("phone");
                      String sex=table.getString("sex");
                      String custadd=table.getString("cusAddress");
                      Customer c=new Customer(custid, custname, phone, sex, custadd);
                      list.add(c);
                  }
              }
          }
        
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    public boolean isUpdateCustomerInformation(int custID, String name, String phone, String sex, String cusAddress) {
    boolean isUpdate = false; 
    Connection cn = null;
    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "UPDATE dbo.Customer SET custName = ?, phone = ?, sex = ?, cusAddress = ? WHERE custID = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, phone);
            st.setString(3, sex);
            st.setString(4, cusAddress);
            st.setInt(5, custID);

            int rowsAffected = st.executeUpdate(); 
            if (rowsAffected > 0) {
                isUpdate = true; 
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return isUpdate;
}
}

