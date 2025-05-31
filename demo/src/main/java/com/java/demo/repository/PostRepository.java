package com.java.demo.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.java.demo.model.Comment;
import com.java.demo.model.Post;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

@Repository
public class PostRepository {

    @PersistenceContext
    private EntityManager em;

    // เพิ่ม
    @Transactional
    public Post insert(Post m) {
        em.persist(m);
        return m;
    }

    // ดึงข้อมูลมาโชว์
    public List<Post> kk() {
        Query data = em.createQuery("from Post");
        return data.getResultList();
    }

    public Post findById(Integer id) {
        return em.find(Post.class, id);
    }

//อัปเดตข้อมูลโพสต์ที่มีการไลค์มาด้วย
    @Transactional
    public Post save(Post post) {
        if (!postIsLikedByUser(post.getId(), post.getAuthor())) {
            // ถ้ายังไม่ถูกกดไลค์, ก็ดำเนินการบันทึกข้อมูล
            em.merge(post); //mergeเพื่ออัปเดตข้อมูลโพสต์ที่มีidนี้
            return post;
        }
        return null;
    }

//ตรวจสอบว่าโพสต์ว่ามี user นี้ไลค์อยู่หรือไม่
    private boolean postIsLikedByUser(Integer postId, String username) {
        //ค้นหาโพสต์โดยใช้idpostและ username
    	Query query = em.createQuery("FROM Post WHERE id = :postId AND love > 0 AND author = :username")
                .setParameter("postId", postId)
                .setParameter("username", username);
        List<Post> resultList = query.getResultList();
        return !resultList.isEmpty();
    }
    
//ตรวจสอบที่ตารางjoinกัน ว่า postid นั้น มี usernameนี้อยู่ไหม     
    @Transactional
    public void unlikePost(Integer postId, String username) {
        Post post = em.find(Post.class, postId);
        if (post != null) { //ถ้ามี-ไลค์
            if (post.getLikedUsernames().contains(username)) {
                post.setLove(post.getLove() - 1);
                post.getLikedUsernames().remove(username);
                em.merge(post);
            }
        }
    }
    
   //เรียกข้อมูลการไลค์โพสต์จากฐานข้อมูล
    public Set<Integer> findLikedPostIdsByUsername(String username) {
        Query query = em.createQuery("SELECT p.id FROM Post p WHERE :username MEMBER OF p.likedUsernames")
                .setParameter("username", username);
        List<Integer> resultList = query.getResultList();
        return new HashSet<>(resultList);
    }
    
    
    public List<Post> searchPosts(String keyword, String category) {
        // ตรวจสอบว่ามีการระบุ category หรือไม่
        if (category != null && !category.isEmpty()) {
            Query query = em.createQuery("from Post where detail like :keyword and category = :category");
            query.setParameter("category", category);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } else {
            // ถ้าไม่ระบุcategory,ให้ค้นหาโพสท์ทั้งหมด
            Query query = em.createQuery("from Post where detail like :keyword");
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        }
    }

    //ลบ
    @Transactional
    public void deleteById(Integer id) {
        Post post = em.find(Post.class, id);
        em.remove(post);
    }
	
 
//คอมเม้นต์
    @Transactional
    public void addComment(Integer postId, String username, String comment) {
        Post post = em.find(Post.class, postId);

        if (post != null) {
            Comment newComment = new Comment();
            newComment.setAuthor(username);
            newComment.setContent(comment);
            newComment.setTimestamp(new Date());
            newComment.setPost(post); //ตั้งค่าpostให้comment

            post.getComments().add(newComment);
            em.merge(post);
        }
    }
    
    public List<Post> findByAuthor(String author) {
        Query query = em.createQuery("from Post where author = :author");
        query.setParameter("author", author);
        return query.getResultList();
    }

    


}

    




