package mybatis.vo;

public class AdminVO {

    private String adminIdx, tIdx, adminId, adminPassword, adminLevel, adminstatus;

    private TheaterVO tvo;


    public TheaterVO getTvo() {
        return tvo;
    }

    public void setTvo(TheaterVO tvo) {
        this.tvo = tvo;
    }

    public String getAdminIdx() {
        return adminIdx;
    }

    public void setAdminIdx(String adminIdx) {
        this.adminIdx = adminIdx;
    }

    public String gettIdx() {
        return tIdx;
    }

    public void settIdx(String tIdx) {
        this.tIdx = tIdx;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public String getAdminLevel() {
        return adminLevel;
    }

    public void setAdminLevel(String adminLevel) {
        this.adminLevel = adminLevel;
    }

    public String getAdminstatus() {
        return adminstatus;
    }

    public void setAdminstatus(String adminstatus) {
        this.adminstatus = adminstatus;
    }

    @Override
    public String toString() {
        return "AdminVO{" +
                "adminIdx='" + adminIdx + '\'' +
                ", tIdx='" + tIdx + '\'' +
                ", adminId='" + adminId + '\'' +
                ", adminPassword='" + adminPassword + '\'' +
                ", adminLevel='" + adminLevel + '\'' +
                ", adminstatus='" + adminstatus + '\'' +
                '}';
    }
}
