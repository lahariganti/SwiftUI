import SwiftUI
import CoreData

struct ContentView: View {
  @State var showOrderSheet = false
  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(entity: Order.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
  var orders: FetchedResults<Order>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(orders) { order in
          HStack {
            VStack(alignment: .leading) {
              Text("\(order.pizzaType) - \(order.numberOfSlices) slices")
                .font(.headline)
              Text("Table \(order.tableNumber)")
                .font(.subheadline)
            }
            Spacer()
            Button(action: {
              self.updateorder(order: order)
            }) {
              Text(order.orderStatus == .pending ? "Prepare" : "Complete")
                .foregroundColor(.blue)
            }
          }
          .frame(height: 50)
        }
        .onDelete(perform: { indexSet in
          for index in indexSet {
            self.viewContext.delete(orders[index])
          }
          
          do {
            try self.viewContext.save()
          } catch {
            print(error.localizedDescription)
          }
        })
      }
      .listStyle(PlainListStyle())
      .sheet(isPresented: self.$showOrderSheet) {
        OrderSheet()
      }
      .navigationTitle("My Orders")
      .navigationBarItems(trailing: Button(action: {
        self.showOrderSheet = true
      }, label: {
        Image(systemName: "plus.circle")
          .imageScale(.large)
      }))
    }
  }
  
  func updateorder(order: Order) {
    let newStatus = order.orderStatus == .pending ? Status.preparing: Status.completed
    self.viewContext.performAndWait {
      order.orderStatus = newStatus
      try? self.viewContext.save()
    }
  }
}

struct OrderSheet: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment (\.presentationMode) var presentationMode
  
  let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
  @State var selectedPizzaIndex = 1
  @State var tableNumber = ""
  @State var numberOfSlices = 4
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Pizza Details")) {
          Picker(selection: self.$selectedPizzaIndex, label:  Text("Pizza Type"), content: {
            ForEach(0..<pizzaTypes.count) {
              Text(self.pizzaTypes[$0]).tag($0)
            }
          })
          
          Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
        }
        
        Section(header: Text("Table")) {
          TextField("Table Number", text: self.$tableNumber)
            .keyboardType(.numberPad)
        }
        
        Button(action: {
          guard self.tableNumber != "" else { return }
          let newOrder = Order(context: self.viewContext)
          newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
          newOrder.orderStatus = .pending
          newOrder.tableNumber = self.tableNumber
          newOrder.numberOfSlices = Int16(self.numberOfSlices)
          newOrder.id = UUID()
          do {
            try viewContext.save()
            print("Order saved")
            self.presentationMode.wrappedValue.dismiss()
          } catch {
            print(error.localizedDescription)
          }
        }, label: {
          Text("Add Order")
            .frame(maxWidth: .infinity, alignment: .center)
        })
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView() .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
