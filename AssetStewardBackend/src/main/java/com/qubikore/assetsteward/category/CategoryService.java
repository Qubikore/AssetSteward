package com.qubikore.assetsteward.category;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<CategoryResponse> getAllCategories(com.qubikore.assetsteward.user.User currentUser) {
        return categoryRepository.findByOrganization(currentUser.getOrganization()).stream()
                .map(CategoryResponse::new)
                .collect(Collectors.toList());
    }

    public CategoryResponse getCategoryById(Long id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        return new CategoryResponse(category);
    }

    public CategoryResponse createCategory(CategoryRequest request, com.qubikore.assetsteward.user.User currentUser) {
        if (categoryRepository.existsByNameAndOrganization(request.getName(), currentUser.getOrganization())) {
            throw new RuntimeException("Category already exists");
        }
        Category category = new Category(request.getName());
        category.setOrganization(currentUser.getOrganization());

        category = categoryRepository.save(category);
        return new CategoryResponse(category);
    }

    public CategoryResponse updateCategory(Long id, CategoryRequest request) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        
        if (!category.getName().equals(request.getName()) && categoryRepository.existsByNameAndOrganization(request.getName(), category.getOrganization())) {
            throw new RuntimeException("Category already exists");
        }

        category.setName(request.getName());
        category = categoryRepository.save(category);
        return new CategoryResponse(category);
    }

    public void deleteCategory(Long id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        categoryRepository.delete(category);
    }
}
