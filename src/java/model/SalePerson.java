/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author user
 */
public class SalePerson {
    private String id;
    private String name;
    private String yearOfBirth;
    private String address;
    private String sex;

    public SalePerson(String id, String name, String yearOfBirth, String address, String sex) {
        this.id = id;
        this.name = name;
        this.yearOfBirth = yearOfBirth;
        this.address = address;
        this.sex = sex;
    }

    public SalePerson() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getYearOfBirth() {
        return yearOfBirth;
    }

    public void setYearOfBirth(String yearOfBirth) {
        this.yearOfBirth = yearOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
    

    
    
}
