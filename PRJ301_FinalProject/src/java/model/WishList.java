/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author user
 */
public class WishList {
   private int id;
   private String custid;
   ArrayList<Car> listcar;

    public WishList(int id, String custid, ArrayList<Car> listcar) {
        this.id = id;
        this.custid = custid;
        this.listcar = listcar;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustid() {
        return custid;
    }

    public void setCustid(String custid) {
        this.custid = custid;
    }

    public ArrayList<Car> getListcar() {
        return listcar;
    }

    public void setListcar(ArrayList<Car> listcar) {
        this.listcar = listcar;
    }
   
}
