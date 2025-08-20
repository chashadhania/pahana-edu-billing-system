package com.pahanaedu.model;

public class User {
    private String username;
    private String password;
    
    // Constructor with parameters
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
  
    public User() {
    }
    
    // Getters
    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
    // Setters
    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
 
    @Override
    public String toString() {
        return "User [username=" + username + "]";
    }
    
  
}