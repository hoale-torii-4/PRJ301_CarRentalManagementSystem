/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Mechanic;
import mylib.DBUtils;

/**
 *
 * @author hoang
 */
public class MechanicDAO {
     public Mechanic checkLogin(String name){
        Mechanic rs=null;
        Connection cn=null;
        try{
          cn=DBUtils.getConnection();
          if(cn!=null){
              String sql = "select mechanicID,mechanicName\n"
                      + "from dbo.Mechanic\n"
                      + "where mechanicName=?";
              PreparedStatement st=cn.prepareStatement(sql);
              st.setString(1,  name);
              
              ResultSet table=st.executeQuery();
                if(table!=null){
                  while(table.next()){
                      String mechenicid=table.getString("mechanicID");
                      String mechanicname=table.getString("mechanicName");
                      rs=new Mechanic(mechenicid, mechanicname);
                      
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
