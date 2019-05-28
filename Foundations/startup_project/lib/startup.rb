require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return @salaries.keys.include? title
    end

    def >(startup)
        return @funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name,title)
        else
            raise "Invalid Title #{title}"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        bill = salaries[employee.title]
        if @funding >= bill
            employee.pay(bill)
            @funding -= bill
        else
            raise "Not Enough Funding #{@funding-bill}"
        end
    end

    def payday
        employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        employee_salaries = employees.map {|employee| salaries[employee.title]}
        employee_salaries.sum / employee_salaries.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each {|k,v| @salaries[k] = v if !(@salaries.keys.include? k)}
        @employees += startup.employees 
        startup.close
    end
end
