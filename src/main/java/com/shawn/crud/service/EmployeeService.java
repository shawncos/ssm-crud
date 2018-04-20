package com.shawn.crud.service;


import com.shawn.crud.bean.Employee;
import com.shawn.crud.bean.EmployeeExample;
import com.shawn.crud.bean.EmployeeExample.Criteria;
import com.shawn.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    //查询所有员工
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }
    //员工保存

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //检验员工名是否可用
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
       // System.out.println(count);
        return count == 0;
    }


    public Employee getEmp(Integer id) {
        Employee employee=employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
}
