from distutils.log import error
import flask
import mysql.connector
import json
import datetime

usernamelogin="root"
passwlogin="Arjun$123"
def connectToDB():
    db = mysql.connector.connect(
        host="localhost",
        user=usernamelogin,
        passwd=passwlogin,
        database = 'retailstore')
    return db

app = flask.Flask(__name__)

"""The main purpose of this API is to change the connection to a user if he logs in as one"""
@app.route('/authenticateUser/<string:username>/<string:passw>')
def authenticateUser(username,passw):
    try:
        global usernamelogin
        global passwlogin
        usernamelogin="root"
        passwlogin="password"
        db = connectToDB()
        cursor = db.cursor()
        cursor.execute(f"select * from user where EmailID='{username}' and Password='{passw}'")
        data=cursor.fetchall()
        if len(data)>0:
            usernamelogin="customer"
            passwlogin=passw
            cursor.execute(f"DROP USER IF EXISTS customer@localhost")
            cursor.execute(f"FLUSH PRIVILEGES")
            cursor.execute(f"CREATE USER customer@localhost IDENTIFIED BY '{passw}'", )
            #cursor.execute(f"GRANT user_role TO customer@localhost")
            cursor.execute(f"grant select on retaildb.usableCouponView to customer@localhost")
            cursor.execute(f"grant select on retaildb.userProductView to customer@localhost")
            cursor.execute(f"grant select on retaildb.categoryUserView to customer@localhost")
            cursor.execute(f"grant select,update on retaildb.inventory to customer@localhost")
            cursor.execute(f"grant select, update,insert,delete on retaildb.items_purchased to customer@localhost")
            cursor.execute(f"grant select, update,insert,delete on retaildb.order_table to customer@localhost")
            cursor.execute(f"grant select on retaildb.shipper to customer@localhost")
            cursor.execute(f"grant select, insert,update,delete on retaildb.billing_details to customer@localhost")
            cursor.execute(f"grant select on retaildb.belongsto to customer@localhost")
            cursor.execute(f"grant select on retaildb.product to customer@localhost")
            cursor.execute(f"grant select on retaildb.brand to customer@localhost")
            cursor.execute(f"grant select on retaildb.category to customer@localhost")
            cursor.execute(f"grant select,update,insert,delete on retaildb.items_contained to customer@localhost")
            cursor.execute(f"grant select on retaildb.cart_data to customer@localhost")
            cursor.execute(f"grant select,update on retaildb.coupon_data to customer@localhost")
            cursor.execute(f"grant select on retaildb.user to customer@localhost")
            cursor.execute(f"grant select on retaildb.protectedUserView to customer@localhost")
            db.close()
            return "Success"
        db.close()
        return "Error"
    except Exception as e:
        return str(e)
    
"""The main purpose of this API is to change the connection to a admin if he logs in as one"""
@app.route('/authenticateAdmin/<string:username>/<string:passw>')
def authenticateAdmin(username,passw):
    try:
        global usernamelogin
        global passwlogin
        usernamelogin="root"
        passwlogin="password"
        db = connectToDB()
        cursor = db.cursor()
        cursor.execute(f"select * from admin_table where username='{username}' and passKey='{passw}'")
        data=cursor.fetchall()
        if len(data)>0:
            usernamelogin="administer" #used as a short form for administrator
            passwlogin=passw
            cursor.execute(f"DROP USER IF EXISTS administer@localhost")
            cursor.execute(f"FLUSH PRIVILEGES")
            cursor.execute(f"CREATE USER administer@localhost IDENTIFIED BY '{passw}'", )
            #cursor.execute(f"GRANT admin_role TO administer@localhost")

            cursor.execute(f"grant all on retaildb.user to administer@localhost")
            cursor.execute(f"grant all on retaildb.coupon_data to administer@localhost")
            #not given admin any data related to cart and order
            cursor.execute(f"grant all on retaildb.category to administer@localhost")
            cursor.execute(f"grant all on retaildb.brand to administer@localhost")
            cursor.execute(f"grant all on retaildb.product to administer@localhost")
            cursor.execute(f"grant all on retaildb.belongsto to administer@localhost")
            cursor.execute(f"grant all on retaildb.billing_details to administer@localhost")
            #for the time being an admin does not have to write alter on other admins
            cursor.execute(f"grant select on retaildb.admin_table to administer@localhost")
            cursor.execute(f"grant all on retaildb.shipper to administer@localhost")
            cursor.execute(f"grant select,update,insert,delete,create,drop on retaildb.order_table to administer@localhost")
            cursor.execute(f"grant select,update,insert,delete,create,drop on retaildb.items_purchased to administer@localhost")
            cursor.execute(f"grant all on retaildb.inventory to administer@localhost")
            cursor.execute(f"grant all on retaildb.userProductView to administer@localhost")
            cursor.execute(f"grant all on retaildb.categoryUserView to administer@localhost")
            cursor.execute(f"grant all on retaildb.protectedUserView to administer@localhost")
            cursor.execute(f"grant all on retaildb.usableCouponView to administer@localhost")



            db.close()
            return "Success"
        db.close()
        return "Error"
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.run(debug=True)