package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Car;
import mylib.DBUtils;

public class CarDAO {

    public List<String> getCarSuggestions1(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, price, model,colour , year FROM Cars WHERE (model LIKE ? OR colour LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                String carInfo = rs.getString("CarID") + " - " + rs.getString("price") + " - " + rs.getString("colour") + " - " + rs.getString("model") + " (" + rs.getInt("year") + ")";

                suggestions.add(carInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return suggestions;
    }

    public List<Car> searchCars(String keyword) {
        List<Car> searchResults = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, serialNumber, model, colour, year, price FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carID = rs.getString("carID");
                String serialNumber = rs.getString("serialNumber");
                String model = rs.getString("model");
                String colour = rs.getString("colour");
                int year = rs.getInt("year");
                double price = rs.getDouble("price");
                searchResults.add(new Car(carID, serialNumber, model, colour, year, price));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return searchResults;
    }

    public List<Car> searchCarByID(String keyword) {
        List<Car> searchResults = new ArrayList<>();
        Connection cn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, serialNumber, model, colour, year, price FROM Cars WHERE status != 0";
            if (keyword.matches("\\d+")) {  // Kiểm tra nếu keyword là số
                sql = sql + " AND carID = " + keyword;
            }
            stmt = cn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String carID = rs.getString("carID");
                String serialNumber = rs.getString("serialNumber");
                String model = rs.getString("model");
                String colour = rs.getString("colour");
                int year = rs.getInt("year");
                double price = rs.getDouble("price");
                searchResults.add(new Car(carID, serialNumber, model, colour, year, price));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return searchResults;
    }

    public Car searchCarByModelByColor(String model, String color) {
        Car car = new Car();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, serialNumber, model, colour, year, price FROM Cars WHERE (model LIKE ? AND colour LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + model + "%");
            stmt.setString(2, "%" + color + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carID = rs.getString("carID");
                String serialNumber = rs.getString("serialNumber");
                int year = rs.getInt("year");
                double price = rs.getDouble("price");
                car = new Car(carID, serialNumber, model, color, year, price);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return car;
    }

    public List<String> getCarSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT serialNumber, model, colour, year FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carInfo = rs.getString("serialNumber") + " - " + rs.getString("model") + " - " + rs.getString("colour") + " - " + rs.getInt("year");
                suggestions.add(carInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return suggestions;
    }

    public Car getCarByID(String cartID) {
        Car car = new Car();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [carID]\n"
                        + ",[serialNumber]\n"
                        + ",[model]\n"
                        + ",[colour]\n"
                        + ",[year]\n"
                        + ",[price]\n"
                        + "FROM [dbo].[Cars]\n"
                        + "WHERE [carID] LIKE ? AND status LIKE 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, cartID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String cartId = table.getString("carID");
                        String serialNumber = table.getString("serialNumber");
                        String model = table.getString("model");
                        String colour = table.getString("colour");
                        double price = table.getDouble("price");
                        int year = table.getInt("year");
                        car = new Car(cartId, serialNumber, model, colour, year, price);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return car;
    }

    public boolean isUpdateCar(Car car) {
        boolean isUpdated = false;
        Connection cn = null;
        PreparedStatement st = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Cars]\n"
                        + "   SET [serialNumber] = ?"
                        + "      ,[model] = ?"
                        + "      ,[colour] = ?"
                        + "      ,[year] = ?"
                        + "       ,[price] = ?"
                        + " WHERE [carID] LIKE ? AND status LIKE 1";
                st = cn.prepareStatement(sql);
                st.setString(1, car.getSerialNumber());
                st.setString(2, car.getModel());
                st.setString(3, car.getColor());
                st.setInt(4, car.getYear());
                st.setDouble(5, car.getPrice());
                st.setString(6, car.getCarId());
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    isUpdated = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isUpdated;
    }

    public boolean isCreateCar(Car newCar) {
        boolean isCreated = false;
        try {
            Connection cn = DBUtils.getConnection();
            if (cn != null) {
                long newID = System.currentTimeMillis();

                String sql = "INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year], [price]) "
                        + "VALUES (?,?,?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setLong(1, newID);
                st.setString(2, newCar.getSerialNumber());
                st.setString(3, newCar.getModel());
                st.setString(4, newCar.getColor());
                st.setInt(5, newCar.getYear());
                st.setDouble(6, newCar.getPrice());
                int row = st.executeUpdate();
                return row > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }

    public boolean isDeleteCar(String carID) {
        Connection cn = null;
        boolean isDelete = false;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Cars] SET [status] = 0\n"
                        + "WHERE [carID] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + carID + "%");
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    isDelete = true;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isDelete;
    }

}
