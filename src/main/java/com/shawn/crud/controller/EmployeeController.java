package com.shawn.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shawn.crud.bean.Employee;
import com.shawn.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/*
 * 处理crud请求
 *
 * */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //这不是一个分页查询：
        //pagehelper插件
        //查询之前，调用,传入页码,以及分页的大小
        PageHelper.startPage(pn, 5);
        //后面紧跟的查询就是分页查询

        List<Employee> emps = employeeService.getAll();
        //使用pageinfo 包装查询后的结果
        //封装了详细的分页信息,可以传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);

        model.addAttribute("pageInfo", page);


        return "list";
    }
}
