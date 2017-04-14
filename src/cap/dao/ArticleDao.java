package cap.dao;

import java.util.List;

import cap.bean.Article;
import cap.bean.User;

public interface ArticleDao {

	/**
	 * ��ȡվ��ָ����Ŀ�Ļ�Ծ�û�
	 * 
	 * return �û���Ϣ���û��б�
	 */
	public abstract List<User> getActiveUser(int num);

	/**
	 * ��userId��ȡ��������
	 */
	public abstract List<Article> getByUserId(int userId);

	/**
	 * ����id��ȡ����
	 */
	public abstract Article getById(int id);

	/**
	 * ����һƪ����
	 * 
	 * return Ӱ������
	 */
	public abstract int insertArticle(String title, int userId, int scgId,
			int cgId, String content, String summary);

	/**
	 * ��������
	 * 
	 * return Ӱ������
	 */
	public abstract int updateArticle(int artId, String title, int userId,
			int scgId, int cgId, String content, String summary);

	/**
	 * ɾ�����£���is_delete�ֶ���Ϊ1
	 * 
	 * return Ӱ������
	 */
	public abstract int deleteArtical(int artId);

	/**
	 * ��ȡ��ǰ����δ���߼�ɾ��������
	 */
	public abstract List<Article> getAllArtical();

	/**
	 * ��������
	 */
	public abstract List<Article> search(String q);

	public abstract List<Article> getArticleByPage(int curPage, int size);

	public abstract List<Article> getArticleByPageUserId(int curPage, int size,
			int userId);

	public abstract List<Article> getBycgIdorscgId(int cgId, int scgId,
			int artId);

	/**
	 * ��ѯ�����ǰ10������
	 * @return
	 */
	public abstract List<Article> topTenArticle();
	
	/**
	 * ���µ����+1
	 * @param artId
	 * @return
	 */
	public int updateCount(int artId);

	

}