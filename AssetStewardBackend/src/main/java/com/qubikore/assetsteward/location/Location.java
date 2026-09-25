package com.qubikore.assetsteward.location;

import jakarta.persistence.*;

@Entity
@Table(name = "locations")
public class Location {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column
    private String address;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private com.qubikore.assetsteward.user.Organization organization;


    public Location() {}

    public Location(String name, String address) {
        this.name = name;
        this.address = address;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public com.qubikore.assetsteward.user.Organization getOrganization() { return organization; }
    public void setOrganization(com.qubikore.assetsteward.user.Organization organization) { this.organization = organization; }

}
