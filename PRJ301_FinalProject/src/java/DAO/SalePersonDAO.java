/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.SalePerson;
import mylib.DBUtils;

/**
 *
 * @author hoang
 */
public class SalePersonDAO {
    public SalePerson checkLogin(String name){
        SalePerson rs=null;
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select salesID,salesName,birthday,sex,salesAddress\n"
                      + "from dbo.SalesPerson\n"
                      + "where salesName=?";
              PreparedStatement st=cn.prepareStatement(sql);
              st.setString(1, name);
              
              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      String salesid=table.getString("salesID");
                      String salesname=table.getString("salesName");
                      String bd=""+table.getString("birthday");
                      String sex=table.getString("sex");
                      String salesadd=table.getString("salesAddress");
                      rs=new SalePerson(salesid, salesname, bd, salesadd, sex);
                      
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
}
