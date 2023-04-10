package edu.inai.coursework3.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CatalogForm {
    @Builder.Default
    private String keywords="";
    private List<String> level; //AllLevels, Beginner, Intermediate, Expert
    @Builder.Default
    private String orderBy="popular"; //popular, new, top
    private List<Long> category; //category ids
    @Builder.Default
    private Double rating=0.0;

//    @Builder.Default
//    private Double minPrice=0.0;
//    @Builder.Default
//    private Double maxPrice=Double.MAX_VALUE;
//    @Builder.Default
//    private String price="all"; //free, paid or all

}
