package cap.bean;

import java.sql.Timestamp;
/**
 * ��ʵ�����Ӧ��ucomment��ͼ��������в�ѯ
 * @author star
 *
 */
public class Ucomment {
	private int aid;//��������
	private int cid;//��������
	private String ccontent;//��������
	private String username;//�����û�
	private String title;//���۵����±���
	private Timestamp publish_time;//���۷���ʱ��
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getPublish_time() {
		return publish_time;
	}
	public void setPublish_time(Timestamp publish_time) {
		this.publish_time = publish_time;
	}
	
	

}
