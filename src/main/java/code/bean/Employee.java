package code.bean;

public class Employee {
    private Integer eId;

    private String eName;

    private String eGender;

    private String eEmail;

    private Integer eDid;

    private Deparment deparment;

    public Employee() {
    }

    public Employee(Integer eId, String eName, String eGender, String eEmail, Integer eDid) {
        this.eId = eId;
        this.eName = eName;
        this.eGender = eGender;
        this.eEmail = eEmail;
        this.eDid = eDid;
    }

    public Employee(Integer eId, String eName, String eGender, String eEmail, Integer eDid, Deparment deparment) {
        this.eId = eId;
        this.eName = eName;
        this.eGender = eGender;
        this.eEmail = eEmail;
        this.eDid = eDid;
        this.deparment = deparment;
    }

    public Deparment getDeparment() {
        return deparment;
    }

    public void setDeparment(Deparment deparment) {
        this.deparment = deparment;
    }

    public Integer geteId() {
        return eId;
    }

    public void seteId(Integer eId) {
        this.eId = eId;
    }

    public String geteName() {
        return eName;
    }

    public void seteName(String eName) {
        this.eName = eName == null ? null : eName.trim();
    }

    public String geteGender() {
        return eGender;
    }

    public void seteGender(String eGender) {
        this.eGender = eGender == null ? null : eGender.trim();
    }

    public String geteEmail() {
        return eEmail;
    }

    public void seteEmail(String eEmail) {
        this.eEmail = eEmail == null ? null : eEmail.trim();
    }

    public Integer geteDid() {
        return eDid;
    }

    public void seteDid(Integer eDid) {
        this.eDid = eDid;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "eId=" + eId +
                ", eName='" + eName + '\'' +
                ", eGender='" + eGender + '\'' +
                ", eEmail='" + eEmail + '\'' +
                ", eDid=" + eDid +
                ", deparment=" + deparment.getdId() +deparment.getdName()+
                '}';
    }
}