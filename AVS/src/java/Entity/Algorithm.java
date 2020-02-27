/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Jisoo
 */
public class Algorithm {
    private int algoID;
    private String algoName;
    private String algoCodeJava;
    private String algoCodeCplus;
    private String algoCodeJS;
    private String algoDescription;
    private int categoryID;
    private String algoDatetime;
    private String algoResource;
    
    public Algorithm() {
        
    }

    public Algorithm(int algoID, String algoName, String algoCodeJava, String algoCodeCplus, String algoCodeJS, String algoDescription, int categoryID, String algoDatetime, String algoResource) {
        this.algoID = algoID;
        this.algoName = algoName;
        this.algoCodeJava = algoCodeJava;
        this.algoCodeCplus = algoCodeCplus;
        this.algoCodeJS = algoCodeJS;
        this.algoDescription = algoDescription;
        this.categoryID = categoryID;
        this.algoDatetime = algoDatetime;
        this.algoResource = algoResource;
    }
    
    

    public int getAlgoID() {
        return algoID;
    }

    public void setAlgoID(int algoID) {
        this.algoID = algoID;
    }

    public String getAlgoName() {
        return algoName;
    }

    public void setAlgoName(String algoName) {
        this.algoName = algoName;
    }

    public String getAlgoCodeJava() {
        return algoCodeJava;
    }

    public void setAlgoCodeJava(String algoCodeJava) {
        this.algoCodeJava = algoCodeJava;
    }

    public String getAlgoCodeCplus() {
        return algoCodeCplus;
    }

    public void setAlgoCodeCplus(String algoCodeCplus) {
        this.algoCodeCplus = algoCodeCplus;
    }

    public String getAlgoCodeJS() {
        return algoCodeJS;
    }

    public void setAlgoCodeJS(String algoCodeJS) {
        this.algoCodeJS = algoCodeJS;
    }

    public String getAlgoDescription() {
        return algoDescription;
    }

    public void setAlgoDescription(String algoDescription) {
        this.algoDescription = algoDescription;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getAlgoDatetime() {
        return algoDatetime;
    }

    public void setAlgoDatetime(String algoDatetime) {
        this.algoDatetime = algoDatetime;
    }

    public String getAlgoResource() {
        return algoResource;
    }

    public void setAlgoResource(String algoResource) {
        this.algoResource = algoResource;
    }

    
    
}
