// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package de.computerlyrik.spring.securityobjects;

import de.computerlyrik.spring.securityobjects.UserDetailsSO;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect UserDetailsSO_Roo_Jpa_Entity {
    
    declare @type: UserDetailsSO: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long UserDetailsSO.id;
    
    @Version
    @Column(name = "version")
    private Integer UserDetailsSO.version;
    
    public Long UserDetailsSO.getId() {
        return this.id;
    }
    
    public void UserDetailsSO.setId(Long id) {
        this.id = id;
    }
    
    public Integer UserDetailsSO.getVersion() {
        return this.version;
    }
    
    public void UserDetailsSO.setVersion(Integer version) {
        this.version = version;
    }
    
}