package com.qubikore.assetsteward.location;

public class LocationResponse {
    private Long id;
    private String name;
    private String address;

    public LocationResponse(Location location) {
        this.id = location.getId();
        this.name = location.getName();
        this.address = location.getAddress();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
