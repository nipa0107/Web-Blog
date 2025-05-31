package com.java.demo.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
public class Post {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String category;
    private String detail;
    private String author;
    private int love;
    private Date timestamp;

    @ElementCollection // เป็นcollectionของอ็อบเจกต์ที่ไม่ใช่Entityในฐานข้อมูล
    @Column(name = "liked_username")
    private Set<String> likedUsernames = new HashSet<>(); //เก็บชุดของชื่อคนไลค์โพสต์

    
    //CascadeType.ALL ทุกกสารปปที่โพสต์จะส่งไปคอมเม้น โพสค์ลบเม้นลบ
    //orphanRemoval = true ถ้ามีการลบ comment ออกจาก comments comment จะในฐานจะลบอตม
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "post_id") //คอลัมภ์เชื่อมกับcomment
    private List<Comment> comments = new ArrayList<>();

    public int getId() {
        return id;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public Set<String> getLikedUsernames() {
        return likedUsernames;
    }

    public void setLikedUsernames(Set<String> likedUsernames) {
        this.likedUsernames = likedUsernames;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void addComment(Comment comment) {
        comments.add(comment);
        comment.setPost(this);
    }

    public void unlikePost(String username) {
        if (likedUsernames.remove(username)) {
            setLove(getLove() - 1);
        }
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getLove() {
        return love;
    }

    public void setLove(int love) {
        this.love = love;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
