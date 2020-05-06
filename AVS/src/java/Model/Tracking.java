/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.math.BigInteger;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class Tracking {
    private String userID;
    private int algoID;
    private Date dateAccess;
    private BigInteger totalTime;
    private int totalPeople;
    private String AlgoName;

    public String getAlgoName() {
        return AlgoName;
    }

    public void setAlgoName(String AlgoName) {
        this.AlgoName = AlgoName;
    }
    
    public int getTotalPeople() {
        return totalPeople;
    }

    public void setTotalPeople(int totalPeople) {
        this.totalPeople = totalPeople;
    }

    
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }



    public int getAlgoID() {
        return algoID;
    }

    public void setAlgoID(int algoID) {
        this.algoID = algoID;
    }

    public Date getDateAccess() {
        return dateAccess;
    }

    public void setDateAccess(Date dateAccess) {
        this.dateAccess = dateAccess;
    }

    public BigInteger getTotalTime() {
        return totalTime;
    }

    public void setTotalTime(BigInteger totalTime) {
        this.totalTime = totalTime;
    }
    
    
}
