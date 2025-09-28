tolk 1.1

struct Message {
    text: string;
    sender: address;
    time: uint32;
}

struct Storage {
    messages: map<address, Message>;
    description: string;
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun sendMessage(text: string) {
    var st = Storage.load();
    let sender = get_caller();

    st.messages.set(sender, Message{text: text, sender: sender, time: blockchain.now()});
    st.description = "Chat contract storing last message per user, map grows indefinitely.";
    st.save();
}
