package com.shawn.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shawn.crud.bean.Employee;
import com.shawn.crud.bean.Msg;
import com.shawn.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
 * 处理crud请求
 * 需要导入jackson的包
 *
 * */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    //检查用户名是否可用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        //System.out.print(empName);
        //先判断用户名是否合法
        String regx="(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名有错误");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }


    //员工保存
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        //后面紧跟的查询就是分页查询

        List<Employee> emps = employeeService.getAll();
        //使用pageinfo 包装查询后的结果
        //封装了详细的分页信息,可以传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);


        return Msg.success().add("pageInfo", page);
    }


  /*  //@RequestMapping("/emps")
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
    }*/
}
