const db = require("../config/db")

const loginUser = async (req, res) => {

    // try {

    //     const data = req.body;
    //     const [rows] = await db.execute(`SELECT * FROM users WHERE roll = ?`, [data.roll]);

    //     // no user exists
    //     if (rows.length == 0) {
    //         return res.status(400).json({
    //             userData: null,
    //             message: "No user exists",
    //             status: false
    //         });
    //     }
    //     // user exists
    //     else if (rows.length == 1) {
    //         const userPassword = rows[0].password;
    //         // correct password
    //         if (data.password == userPassword) {
    //             const userData = {
    //                 roll: rows[0].roll,
    //                 name: rows[0].name,
    //                 mobile: rows[0].mobile,
    //                 dept: rows[0].dept,
    //                 email: rows[0].email,
    //             };
    //             return res.status(201).json({
    //                 userData: userData,
    //                 message: "Login successful",
    //                 status: true
    //             });
    //         }
    //         // wrong password 
    //         else {
    //             return res.status(201).json({
    //                 userData: null,
    //                 message: "Wrong password",
    //                 status: false
    //             });
    //         }
    //     }

    // } 
    try {

        const data = req.body;
        const isaa = data.isaa;

        console.log(isaa);

        if (!isaa) {
            table = "users";
        }
        else {
            table = "admins"
        }

        const [rows] = await db.execute(`SELECT * FROM ${table} WHERE roll = ?`, [data.roll]);

        // no user exists
        if (rows.length == 0) {
            return res.status(400).json({
                userData: null,
                message: "No user exists",
                status: false
            });
        }
        // user exists
        else if (rows.length == 1) {
            const userPassword = rows[0].password;
            // correct password
            if (data.password == userPassword) {
                const userData = {
                    roll: rows[0].roll,
                    name: rows[0].name,
                    mobile: rows[0].mobile,
                    dept: rows[0].dept,
                    email: rows[0].email,
                    isaa: isaa,
                };
                return res.status(201).json({
                    userData: userData,
                    message: "Login successful",
                    status: true
                });
            }
            // wrong password 
            else {
                return res.status(201).json({
                    userData: null,
                    message: "Wrong password",
                    status: false
                });
            }
        }
    }
    catch {
        return res.status(500).json({
            userData: null,
            message: "Internal Server Error",
            status: false
        })
    }
}

const registerUser = async (req, res) => {

    try {
        const data = req.body;
        const [rows] = await db.execute(`SELECT * FROM users WHERE roll = ?`, [data.roll]);

        // check if user exists
        if (rows.length > 0) {
            return res.status(400).json({
                message: 'User already exists',
                status: false
            });
        }
        // if it doesn't, register it
        else {
            await db.execute(
                `INSERT INTO users (roll, name, mobile, dept, email, password) VALUES (?, ?, ?, ?, ?, ?)`,
                [data.roll, data.name, data.mobile, data.dept, data.email, data.password]
            );

            res.status(201).json({
                message: 'User registered successfully',
                status: true
            });
        }


    } catch (error) {
        // if some error occurs
        console.error('Error registering user:', error);
        res.status(500).json({
            message: 'Internal Server Error',
            status: false
        });
    }
};

const modifyUser = async (req, res) => {
    const data = req.body;
    try {

        await db.execute(`UPDATE users 
            SET name = ?, 
                mobile = ?, 
                email = ? 
            WHERE roll = ?`,
            [data.name, data.phone, data.email, data.rollNo]
        );

        res.status(201).json({
            message: "User modified.",
            status: true,
        });

    } catch (error) {
        console.error("Error while updating user:", error.message); // Log the error for debugging
        res.status(400).json({
            message: "Some error encountered.",
            status: false
        });
    }
}


module.exports = { loginUser, registerUser, modifyUser };