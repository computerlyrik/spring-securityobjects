// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package de.computerlyrik.spring.securityobjects;

import de.computerlyrik.spring.securityobjects.UserDetailsSO;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

privileged aspect UserDetailsSO_Roo_Finder {
    
    public static TypedQuery<UserDetailsSO> UserDetailsSO.findUserDetailsSOByUsernameEquals(String username) {
        if (username == null || username.length() == 0) throw new IllegalArgumentException("The username argument is required");
        EntityManager em = UserDetailsSO.entityManager();
        TypedQuery<UserDetailsSO> q = em.createQuery("SELECT o FROM UserDetailsSO AS o WHERE o.username = :username", UserDetailsSO.class);
        q.setParameter("username", username);
        return q;
    }
    
}
