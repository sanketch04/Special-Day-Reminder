package com.sdr.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sdr.DTO.FestivalDTO;

@Service
public class FestivalService {

    public List<FestivalDTO> getFestivals(int month) {

        List<FestivalDTO> list = new ArrayList<>();

        switch (month) {

            case 1: // January
                list.add(new FestivalDTO(
                    "Makar Sankranti",
                    "/assets/festivals/january/makar_sankranti.jpg"
                ));
                break;

            case 3: // March
                list.add(new FestivalDTO(
                    "Holi",
                    "/assets/festivals/march/holi.jpg"
                ));
                break;

            case 10: // October
                list.add(new FestivalDTO(
                    "Dussehra",
                    "/assets/festivals/october/dussehra.jpg"
                ));
                list.add(new FestivalDTO(
                    "Diwali",
                    "/assets/festivals/october/diwali.jpg"
                ));
                break;
        }

        return list;
    }
}
