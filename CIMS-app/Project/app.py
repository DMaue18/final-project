from flask import Flask
from flask import render_template
from flask import request
from flask import redirect
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)

app.config["MYSQL_USER"]="flask_user"
app.config["MYSQL_PASSWORD"]="Password"
app.config["MYSQL_DB"]="CIMS"
app.config["MYSQL_CURSORCLASS"]="DictCursor"

mysql = MySQL(app)
@app.route("/")
def index():
    return render_template("index.html")

@app.route("/addincidents", methods=["GET", "POST"])
def addincidents():
    cur = mysql.connection.cursor()
    if request.method == "POST":
        type = request.form["type"]
        description = request.form["description"]
        affected_areas = request.form["affectedAreas"]
        timestamp = request.form["timeStamp"]
        status = request.form["status"]
        add_query = "INSERT INTO Incidents (Type, Description, AffectedAreas, Timestamp, Status) VALUES (%s, %s, %s, %s, %s)"

        cur.execute(add_query, (type, description, affected_areas, timestamp, status))

        mysql.connection.commit()

        return redirect("/Incidents")
    
    else:
        return render_template("addincidents.html", addincidents="", action="addincidents")  
    

@app.route("/Incidents")
def Incidents():
    cur=mysql.connection.cursor()
    cur.execute("SELECT IncidentID, Type, Description, AffectedAreas, TimeStamp, Status FROM Incidents")
    resultset=cur.fetchall()
    return render_template("Incidents.html", Incidents=resultset)

@app.route("/RootCauses")
def RootCauses():
    cur=mysql.connection.cursor()
    cur.execute("SELECT RootCauseID, IncidentID, RootCauseDescription, Vulnerabilities, ImpactLevel FROM RootCauses")
    resultset=cur.fetchall()
    return render_template("RootCauses.html", RootCauses=resultset)

@app.route("/Measures")
def Measures():
    cur=mysql.connection.cursor()
    cur.execute("SELECT MeasureID, IncidentID, CorrectiveMeasures, PreventiveMeasures, ImplementationDate FROM Measures")
    resultset=cur.fetchall()
    return render_template("Measures.html", Measures=resultset)

if __name__=="__main__":
    app.run(debug=True)