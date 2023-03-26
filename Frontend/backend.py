from flask import Flask, render_template, request
import MySQLdb

app = Flask(__name__)

# MySQL configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Arjun$123'
app.config['MYSQL_DB'] = 'retailstore'

mysql = MySQLdb.connect(host=app.config['MYSQL_HOST'], user=app.config['MYSQL_USER'],password=app.config['MYSQL_PASSWORD'], db=app.config['MYSQL_DB'])

@app.route('/customer_login', methods=['POST'])
def customer_login():
    username = request.form['username']
    password = request.form['password']

    cursor = mysql.cursor()
    cursor.execute("INSERT INTO account (Username, Password) VALUES (%s, %s)", (username, password))
    mysql.commit()
    cursor.close()

    return 'Customer login details successfully inserted into database.'

@app.route('/customer_signup', methods=['POST'])
def customer_signup():
    customer_name = request.form['customer_name']
    dob = request.form['dob']
    gender = request.form['gender']
    customer_address = request.form['customer_address']
    phone_no = request.form['phone_no']
    email = request.form['email']
    password = request.form['password']
    confirm_password = request.form['confirm_password']

    if password != confirm_password:
        return 'Passwords do not match. Please try again.'

    cursor = mysql.cursor()
    cursor.execute("INSERT INTO customer_signup (customer_name, dob, gender, customer_address, phone_no, email, password) VALUES (%s, %s, %s, %s, %s, %s, %s)", (customer_name, dob, gender, customer_address, phone_no, email, password))
    mysql.commit()
    cursor.close()

    return 'Customer signup details successfully inserted into database.'

if __name__ == '__main__':
    app.run(debug=True)
