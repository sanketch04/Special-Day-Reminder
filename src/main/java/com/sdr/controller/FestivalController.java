package com.sdr.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sdr.DTO.FestivalCardDTO;
@RestController
@RequestMapping("/api/festivals")
public class FestivalController {
	@GetMapping
	public List<FestivalCardDTO> getFestivalImages(
	        @RequestParam int month,
	        HttpServletRequest request) {

	    String[] months = {
	        "january","feb","march","april","may","june",
	        "july","august","sept","october","november","december"
	    };

	    String folder = months[month];
	    String realPath = request.getServletContext()
	            .getRealPath("/assets/festivals/" + folder);

	    File dir = new File(realPath);
	    List<FestivalCardDTO> result = new ArrayList<>();

	    if (dir.exists()) {
	        File[] files = dir.listFiles((d, name) ->
	                name.endsWith(".jpg") || name.endsWith(".png"));

	        if (files != null) {
	            List<File> list = Arrays.asList(files);
	            Collections.shuffle(list);

	            for (int i = 0; i < Math.min(3, list.size()); i++) {
	                String fileName = list.get(i).getName();

	                String title = fileName
	                        .replace(".jpg","")
	                        .replace(".png","")
	                        .replace("_"," ")
	                        .toUpperCase();

	                result.add(new FestivalCardDTO(
	                    request.getContextPath()
	                    + "/assets/festivals/" + folder + "/" + fileName,
	                    title
	                ));
	            }
	        }
	    }

	    while (result.size() < 3) {
	        int i = result.size() + 1;
	        result.add(new FestivalCardDTO(
	            request.getContextPath()
	            + "/assets/festivals/default/default" + i + ".jpg",
	            "Festival"
	        ));
	    }

	    return result;
	}

}

