#  Tableview 禁止下拉,允许上拉

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = self.mainTableView.contentOffset;
    if (offset.y <= 0) {
        offset.y = 0;
    }self.mainTableView.contentOffset = offset;
}
