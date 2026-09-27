package com.qubikore.assetsteward.category;

import jakarta.persistence.*;

@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private com.qubikore.assetsteward.user.Organization organization;


    public Category() {}

    public Category(String name) {
        this.name = name;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public com.qubikore.assetsteward.user.Organization getOrganization() { return organization; }
    public void setOrganization(com.qubikore.assetsteward.user.Organization organization) { this.organization = organization; }

}
