package code.bean;

public class Deparment {
    private Integer dId;

    private String dName;

    public Deparment() {
    }

    public Deparment(Integer dId, String dName) {
        this.dId = dId;
        this.dName = dName;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public String getdName() {
        return dName;
    }

    public void setdName(String dName) {
        this.dName = dName == null ? null : dName.trim();
    }

    @Override
    public String toString() {
        return "Deparment{" +
                "dId=" + dId +
                ", dName='" + dName + '\'' +
                '}';
    }
}