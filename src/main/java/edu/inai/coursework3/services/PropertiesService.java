package edu.inai.coursework3.services;

import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class PropertiesService {
    private final SpringDataWebProperties pageableDefaultProps;
    private final CourseService courseService;
    private final UserService userService;

    public int getDefaultPageSize() {
        return pageableDefaultProps.getPageable().getDefaultPageSize();
    }


    public <T> void fillPaginationDataModel(Model model, Page<T> list, String name, String baseUri) {
        if (list.hasNext()) {
            model.addAttribute("nextPageLink", constructPageUri(baseUri, list.nextPageable().getPageNumber()));
        }

        if (list.hasPrevious()) {
            model.addAttribute("prevPageLink", constructPageUri(baseUri, list.previousPageable().getPageNumber()));
        }


        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());
        model.addAttribute(name, courseService.parseCourseDtoFromList((List<Course>) list.getContent()));
    }

    public <T> void fillPaginationDataModelUsers(Model model, Page<T> list, String name, String baseUri) {
        if (list.hasNext()) {
            model.addAttribute("nextPageLink", constructPageUri(baseUri, list.nextPageable().getPageNumber()));
        }

        if (list.hasPrevious()) {
            model.addAttribute("prevPageLink", constructPageUri(baseUri, list.previousPageable().getPageNumber()));
        }


        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());
        model.addAttribute(name, userService.parseUserDtoFromList((List<User>) list.getContent()));
    }

    private static String constructPageUri(String uri, int page) {
        if(uri.contains("?")){
            return String.format("%s&page=%s", uri, page);
        }else{
            return String.format("%s?page=%s",uri,page);
        }

    }

    public static String getFullURL(HttpServletRequest request) {
        StringBuilder requestURL = new StringBuilder(request.getRequestURI());
        String queryString = getQueryStringWithoutPage(request);

        if (queryString == null) {
            return requestURL.toString();
        } else {
            return requestURL.append('?').append(queryString).toString();
        }
    }

    private static String getQueryStringWithoutPage(HttpServletRequest request){
        String queryString = request.getQueryString();
        StringBuilder sb=new StringBuilder();

        if(queryString==null){
            return null;
        }else{
            String[] listOfQueries=queryString.split("&");
            for (int i = 0; i < listOfQueries.length; i++) {
                if(!listOfQueries[i].startsWith("page=")){
                    sb.append(listOfQueries[i]);
                    if(i!=(listOfQueries.length-1)){
                        sb.append("&");
                    }
                }

            }
        }

        return sb.toString();
    }

}
