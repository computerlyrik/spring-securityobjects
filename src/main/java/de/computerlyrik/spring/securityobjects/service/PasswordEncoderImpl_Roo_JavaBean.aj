// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package de.computerlyrik.spring.securityobjects.service;

import de.computerlyrik.spring.securityobjects.service.PasswordEncoderImpl;

privileged aspect PasswordEncoderImpl_Roo_JavaBean {
    
    public String PasswordEncoderImpl.getSalt() {
        return this.salt;
    }
    
    public void PasswordEncoderImpl.setSalt(String salt) {
        this.salt = salt;
    }
    
    public String PasswordEncoderImpl.getHash() {
        return this.hash;
    }
    
    public void PasswordEncoderImpl.setHash(String hash) {
        this.hash = hash;
    }
    
}
